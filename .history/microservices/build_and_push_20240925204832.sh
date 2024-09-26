#!/bin/bash

# List of your microservice directories
services=("rabbitmq" "orders-db" "orders" "checkout-redis" "checkout" "carts-db" "carts" "catalog-db" "catalog" "assets" "ui")

# DockerHub username
DOCKERHUB_USER="bettysami"

# Build and push for each service
for service in "${services[@]}"; do
  echo "Building and pushing $service ..."
  cd microservices/$service
  docker build -t $DOCKERHUB_USER/$service:1.0.0 .
  docker push $DOCKERHUB_USER/$service:1.0.0}
  cd ../..
done