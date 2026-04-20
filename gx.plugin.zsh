# gx - kubectx-style Google Cloud project switcher
# Requires: gcloud, fzf

# gx: permanently switch gcloud project (gcloud config set project)
gx() {
  local project
  project=$(gcloud projects list --format='value(projectId)' 2>/dev/null | fzf --prompt='gcloud project> ')
  [ -z "$project" ] && return 0
  if gcloud config set project "$project" 2>/dev/null; then
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
