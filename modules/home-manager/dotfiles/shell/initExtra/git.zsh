fetch_remote_branch() {
  local branch
  branch=$(git branch -r | grep 'origin/' | sed 's|origin/||' | fzf --prompt="Select a branch: " --height=40% --reverse)
  
  if [[ -n "$branch" ]]; then
    git checkout -b "$branch" "origin/$branch"
  else
    echo "No branch selected."
  fi
}

alias gfb="fetch_remote_branch"
