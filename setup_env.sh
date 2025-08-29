#!/bin/bash

echo "Starting environment setup..."

# --- Install common tools ---
echo "Updating package lists and installing common tools..."
sudo apt update
sudo apt install -y python3-pip nodejs npm git

# --- Python Virtual Environment Setup ---
echo "Setting up Python virtual environment..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "Virtual environment 'venv' created."
else
    echo "Virtual environment 'venv' already exists."
fi

# Activate virtual environment (for current session)
source venv/bin/activate
echo "Virtual environment activated."

# Install Python dependencies if requirements.txt exists
if [ -f "requirements.txt" ]; then
    echo "Installing Python dependencies from requirements.txt..."
    pip install -r requirements.txt
else
    echo "No requirements.txt found. Skipping Python dependency installation."
fi

# --- Set up Environment Variables (Examples) ---
echo "Setting up example environment variables..."
# Example: Link to the user's myhome directory
export MY_HOME_DATA_DIR="/home/serverhustle/gemini/home/myhome_link"
echo "MY_HOME_DATA_DIR set to $MY_HOME_DATA_DIR"

# Example: Link to the tech.ula data directory
export TECH_ULA_DATA_DIR="/home/serverhustle/gemini/home/data_tech_ula"
echo "TECH_ULA_DATA_DIR set to $TECH_ULA_DATA_DIR"

# --- Basic Project Structure (Optional, for new projects) ---
# echo "Creating basic project structure (if starting a new project)..."
# mkdir -p src tests docs

echo "Environment setup complete. Remember to 'source venv/bin/activate' in new terminal sessions."
