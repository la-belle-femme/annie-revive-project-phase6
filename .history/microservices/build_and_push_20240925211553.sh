#!/bin/bash

# List of your microservice directories
services=("rabbitmq" "orders-db" "orders" "checkout-redis" "checkout" "carts-db" "carts" "catalog-db" "catalog" "assets" "ui")

# DockerHub username
DOCKERHUB_USER="bettysami"

# Image version
IMAGE_VERSION="1.0.0"

# Build and push for each service
for service in "${services[@]}"; do
  echo "Building and pushing $service ..."

  # Check if directory exists
  if [ -d "microservices/$service" ]; then
    cd microservices/$service

    # Check if Dockerfile exists
    if [ -f "Dockerfile" ]; then
      docker build -t $DOCKERHUB_USER/s5annie-revive-$service:$IMAGE_VERSION .
      docker push $DOCKERHUB_USER/s5annie-revive-$service:$IMAGE_VERSION
    else
      echo "Dockerfile not found in $service directory"
    fi

    cd ../..
  else
    echo "Directory microservices/$service does not exist"
  fi
done
