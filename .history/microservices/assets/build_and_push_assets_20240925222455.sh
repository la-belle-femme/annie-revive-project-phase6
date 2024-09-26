#!/bin/bash

# Set your Docker Hub username
DOCKER_USERNAME="bettysami"

# Image name and tag
IMAGE_NAME="s5annie-revive-assets"
IMAGE_TAG="latest"

# Full image name
FULL_IMAGE_NAME="$DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG"

# Build the Docker image
echo "Building Docker image..."
docker build -t $FULL_IMAGE_NAME .

# Check if build was successful
if [ $? -ne 0 ]; then
    echo "Docker build failed"
    exit 1
fi

# Push the image to Docker Hub
echo "Pushing image to Docker Hub..."
docker push $FULL_IMAGE_NAME

# Check if push was successful
if [ $? -ne 0 ]; then
    echo "Docker push failed"
    exit 1
fi

echo "Successfully built and pushed $FULL_IMAGE_NAME to Docker Hub"