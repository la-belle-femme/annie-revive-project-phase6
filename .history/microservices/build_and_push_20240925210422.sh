#!/bin/bash

# List of your microservice directories
services=("rabbitmq" "orders-db" "orders" "checkout-redis" "checkout" "carts-db" "carts" "catalog-db" "catalog" "assets" "ui")

# DockerHub username
DOCKERHUB_USER="bettysami"

# Image version
IMAGE_VERSION="1.0.0"

# Root directory
ROOT_DIR="/c/Users/13477/Dropbox/LULU-CHANCELIER-ANNIE/PHASE-6/microservices"

# Build and push for each service
for service in "${services[@]}"; do
  echo "Building and pushing $service ..."
  cd $ROOT_DIR/$service  # Use absolute path

  # Build the Docker image with the required format
  docker build -t $DOCKERHUB_USER/s5annie-revive-$service:$IMAGE_VERSION .

  # Push the Docker image to DockerHub
  docker push $DOCKERHUB_USER/s5annie-revive-$service:$IMAGE_VERSION

  cd $ROOT_DIR  # Return to the root directory after each build
done
