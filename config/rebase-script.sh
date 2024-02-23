#!/bin/bash

# Get the number of commits ahead of the remote branch
commits=$(git rev-list --count @{u}..HEAD)

# Check if there are any commits to rebase
if [ $commits -eq 0 ]; then
    echo "No commits to rebase."
    exit 0
fi

# Perform automatic rebase to squash commits
git reset --soft HEAD~$((commits-1))

# Prompt user to enter a new commit message for the squashed commit
echo "Enter a new commit message for the squashed commit:"
read new_commit_message

# Amend the squashed commit with the new commit message
git commit --amend -m "$new_commit_message"

echo "Rebase complete. Squashed commits and amended message."
