#!/bin/sh

# An example hook script to verify what is about to be pushed.  Called by "git
# push" after it has checked the remote status, but before anything has been
# pushed.  If this script exits with a non-zero status nothing will be pushed.
#
# This hook is called with the following parameters:
#
# $1 -- Name of the remote to which the push is being done
# $2 -- URL to which the push is being done
#
# If pushing without using a named remote those arguments will be equal.
#
# Information about the commits which are being pushed is supplied as lines to
# the standard input in the form:
#
#   <local ref> <local oid> <remote ref> <remote oid>
#
# This sample shows how to prevent push of commits where the log message starts
# with "WIP" (work in progress).


#!/bin/bash

# Get the number of commits being pushed
commits=$(git rev-list --count @{u}..HEAD)

# Check if the number of local commits differ from the remote branch by more than 1
if [ $commits -gt 1 ]; then
    echo "Error: You must squash your commits into one before pushing."
    exit 1
fi

# Get the squashed commit message
squashed_commit_msg=$(git log --format=%B -n 1 HEAD)

# Validate the commit message format
if ! [[ $squashed_commit_msg =~ ^(feat/|fix/|chore/)[A-Za-z0-9_\-]+:[[:space:]]*.*[^\s].*$ ]]; then
    echo "Error: The squashed commit message must start with 'feat/', 'fix/', or 'chore/' followed by a story name and a colon, and the message must not be empty."
    exit 1
fi

# If the commit message format is valid, exit with success
exit 0

