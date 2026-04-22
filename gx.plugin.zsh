# gx - kubectx-style Google Cloud project switcher
# Requires: gcloud, fzf

# gx: permanently switch gcloud project (gcloud config set project)
# gx -: switch to the previous project
gx() {
  local project current

  if [ "$1" = "-" ]; then
    if [ -z "${_GX_PREVIOUS_PROJECT:-}" ]; then
      echo "gx: no previous project" >&2
      return 1
    fi
    project="$_GX_PREVIOUS_PROJECT"
  else
    project=$(gcloud projects list --format='value(projectId)' 2>/dev/null | fzf --prompt='gcloud project> ')
    [ -z "$project" ] && return 0
  fi

  current=$(gcloud config get-value project 2>/dev/null)

  if [ "$project" = "$current" ]; then
    echo "Already on project: $project"
    return 0
  fi

  if gcloud config set project "$project" 2>/dev/null; then
    _GX_PREVIOUS_PROJECT="$current"
    echo "Switched to project: $project"
  fi
}

# tgx: temporarily switch gcloud project for this shell session only
tgx() {
  local project
  project=$(gcloud projects list --format='value(projectId)' 2>/dev/null | fzf --prompt='gcloud project (temp)> ')
  [ -z "$project" ] && return 0
  export CLOUDSDK_CORE_PROJECT="$project"
  echo "CLOUDSDK_CORE_PROJECT=$project (session only)"
}
