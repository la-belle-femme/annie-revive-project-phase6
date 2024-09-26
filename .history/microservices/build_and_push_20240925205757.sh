#!/bin/bash

# List of your microservice directories
services=("rabbitmq" "orders-db" "orders" "checkout-redis" "checkout" "carts-db" "carts" "catalog-db" "catalog" "assets" "ui")

# DockerHub username
DOCKERHUB_USER="yourdockerhubusername"

# Image version
IMAGE_VERSION="1.0.0"

# Build and push for each service
for service in "${services[@]}"; do
  echo "Building and pushing $service ..."
  cd microservices/$service
  
  # Build the Docker image with the required format
  docker build -t $DOCKERHUB_USER/s5annie-revive-$service:$IMAGE_VERSION .
  
  # Push the Docker image to DockerHub
  docker push $DOCKERHUB_USER/s5annie-revive-$service:$IMAGE_VERSION
  
  cd ../..
done
