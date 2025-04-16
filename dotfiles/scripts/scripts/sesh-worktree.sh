#!/bin/bash
set -euo pipefail

# Check for dependencies: git, fzf, and tmux.
for cmd in git fzf tmux; do
	if ! command -v "$cmd" &>/dev/null; then
		echo "Error: '$cmd' is required but not installed." >&2
		exit 1
	fi
done

# Ensure we are inside a Git repository.
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
	echo "Error: This is not a Git repository." >&2
	exit 1
fi

# Get a list of existing worktrees, excluding those ending with ".bare"
worktrees=$(git worktree list | awk '{print $1}' | grep -v '\.bare$')

if [[ -z "$worktrees" ]]; then
	echo "No worktrees found in the repository."
	exit 1
fi

# Use fzf for worktree selection.
selected_worktree=$(echo "$worktrees" | fzf +m --prompt="Select a worktree: ")

if [[ -z "$selected_worktree" ]]; then
	echo "No worktree selected. Exiting."
	exit 1
fi

# Construct a session name using the last two directories of the selected worktree.
session_name="$(basename "$(dirname "$selected_worktree")")/$(basename "$selected_worktree")"

# If a tmux session already exists, switch to it. Otherwise, create a new one.
if tmux has-session -t "$session_name" 2>/dev/null; then
	tmux switch-client -t "$session_name"
else
	# Use the user's default shell if available.
	user_shell="${SHELL:-/bin/bash}"
	tmux new-session -d -s "$session_name" "cd '$selected_worktree' && exec $user_shell"
	tmux switch-client -t "$session_name"
fi

#
# #!/bin/bash
#
# # Get a list of existing worktrees, filtering out those ending with ".bare"
# worktrees=$(git worktree list | awk '{print $1}' | grep -v '\.bare$')
#
# # Check if there are any worktrees
# if [[ -z "$worktrees" ]]; then
# 	echo "No worktrees found in the repository."
# 	exit 1
# fi
#
# # List the existing worktrees using fzf for selection
# selected_worktree=$(echo "$worktrees" | fzf +m --prompt="Select a worktree:")
#
# # Check if the selected worktree exists
# if [[ -z "$selected_worktree" ]]; then
# 	echo "No worktree selected. Exiting."
# 	exit 1
# fi
#
# # Extract the last two directories from the selected worktree path
# session_name=$(basename $(dirname "$selected_worktree"))/$(basename "$selected_worktree")
#
# # Check if a tmux session exists for the selected worktree
# if tmux has-session -t "$session_name" 2>/dev/null; then
# 	# If session exists, switch to it
# 	tmux switch-client -t "$session_name"
# else
# 	# If session doesn't exist, create a new tmux session for the selected worktree
# 	tmux new-session -d -s "$session_name" "cd '$selected_worktree'; exec zsh"
# 	tmux switch-client -t "$session_name"
# fi
