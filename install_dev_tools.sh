#!/bin/bash
set -e

echo " Starting DevOps tools installation"

echo "Updating package list..."
sudo apt update -y

if ! command -v docker &> /dev/null
then
    echo "Installing Docker..."
    sudo apt install -y docker.io
    sudo systemctl enable docker
    sudo systemctl start docker
    echo "Docker installed successfully."
else
    echo "Docker is already installed."
fi

if ! command -v docker-compose &> /dev/null
then
    echo "🐙 Installing Docker Compose..."
    sudo apt install -y docker-compose
    echo "Docker Compose installed successfully."
else
    echo "Docker Compose is already installed."
fi

if ! command -v python3 &> /dev/null
then
    echo "Installing Python 3..."
    sudo apt install -y python3 python3-pip
    echo "Python installed successfully."
else
    PY_VER=$(python3 -V 2>&1)
    echo "$PY_VER is already installed."
fi

if ! python3 -m django --version &> /dev/null
then
    echo "Installing Django..."
    pip3 install django
    echo "Django installed successfully."
else
    DJ_VER=$(python3 -m django --version)
    echo "Django $DJ_VER is already installed."
fi

echo "====================================="
echo "🎉 Installation completed successfully!"
