#!/bin/bash
# provision.sh - Full DevOps Environment Provisioning Script

set -e  # Exit on any error

echo "========================================================="
echo "Starting Automated Provisioning of Full-Stack DevOps Env"
echo "========================================================="

# Check if Docker and Docker Compose are installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed. Please install it first."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "Error: Docker Compose is not installed. Please install it first."
    exit 1
fi

# Copy environment example if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating .env file from .env.example..."
    cp .env.example .env
    echo "!!! PLEASE EDIT THE .env FILE WITH YOUR SECRETS BEFORE PROCEEDING !!!"
    exit 1
fi

# Build and start all containers in detached mode
echo "Building and launching containers with Docker Compose..."
docker-compose up -d --build

echo ""
echo "========================================================="
echo "Provisioning Complete!"
echo "========================================================="
echo "Your services are starting up. It may take a minute for all to be healthy."
echo ""
echo "Access your application at: http://localhost"
echo "Django Admin at: http://localhost/admin (user: admin, pass: adminpass)"
echo ""
echo "To view logs: docker-compose logs -f"
echo "To stop: docker-compose down"
echo "========================================================="