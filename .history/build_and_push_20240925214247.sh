#!/bin/bash

# Print current directory
echo "Current directory: $(pwd)"

# List contents of current directory
echo "Directory contents:"
ls -R

# Replace with your Docker Hub username
DOCKER_USERNAME="yourdockerhubusername"

# Array of services
services=(
    "rabbitmq"
    "orders-db"
    "orders"
    "checkout-redis"
    "checkout"
    "carts-db"
    "carts"
    "catalog-db"
    "catalog"
    "assets"
    "ui"
)

# Function to build and push a service
build_and_push() {
    local service=$1
    echo "Building and pushing $service ..."
    
    if [ ! -d "microservices/$service" ]; then
        echo "Error: Directory microservices/$service does not exist."
        return 1
    fi
    
    cd "microservices/$service" || { echo "Error: Unable to change to directory microservices/$service"; return 1; }
    
    if [ ! -f "Dockerfile" ]; then
        echo "Error: Dockerfile not found in microservices/$service"
        cd ../..
        return 1
    fi
    
    docker build -t "$DOCKER_USERNAME/s5annie-revive-$service" .
    if [ $? -ne 0 ]; then
        echo "Error: Docker build failed for $service"
        cd ../..
        return 1
    fi
    
    docker push "$DOCKER_USERNAME/s5annie-revive-$service"
    if [ $? -ne 0 ]; then
        echo "Error: Docker push failed for $service"
        cd ../..
        return 1
    fi
    
    cd ../..
    return 0
}

# Main loop
for service in "${services[@]}"
do
    build_and_push "$service"
done

echo "Build and push process completed."