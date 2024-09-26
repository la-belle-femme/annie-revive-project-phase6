#!/bin/bash

# Set the GitHub repository URL
REPO_URL="https://github.com/la-belle-femme/annie-revive-project-phase6.git"

# Print current directory
echo "Current directory: $(pwd)"

# Check if .git directory exists
if [ ! -d ".git" ]; then
    echo "Initializing Git repository..."
    git init
    if [ $? -ne 0 ]; then
        echo "Error: Failed to initialize Git repository."
        exit 1
    fi
fi

# Check if there are any changes to commit
if git status --porcelain | grep -q '^'; then
    echo "Changes detected. Proceeding with commit."
else
    echo "No changes to commit. Exiting."
    exit 0
fi

# Add all files to staging
echo "Adding all files to staging..."
git add .
if [ $? -ne 0 ]; then
    echo "Error: Failed to add files to staging."
    exit 1
fi

# Commit changes
echo "Committing changes..."
read -p "Enter commit message: " commit_message
git commit -m "$commit_message"
if [ $? -ne 0 ]; then
    echo "Error: Failed to commit changes."
    exit 1
fi

# Check if remote origin exists
if ! git remote | grep -q 'origin'; then
    echo "Adding remote origin..."
    git remote add origin $REPO_URL
    if [ $? -ne 0 ]; then
        echo "Error: Failed to add remote origin."
        exit 1
    fi
fi

# Push to GitHub
echo "Pushing to GitHub..."
git push -u origin master
if [ $? -ne 0 ]; then
    echo "Error: Failed to push to GitHub. You might need to pull changes first or force push."
    read -p "Do you want to force push? (y/n): " force_push
    if [ "$force_push" = "y" ]; then
        git push -u origin master --force
        if [ $? -ne 0 ]; then
            echo "Error: Force push failed."
            exit 1
        fi
    else
        echo "Push aborted."
        exit 1
    fi
fi

echo "Successfully pushed to GitHub repository."