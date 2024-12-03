#!/bin/sh
set -e -x -v

echo "Downloading ln software"
# Define the SSH command
GIT_SSH_COMMAND='ssh -i /run/secrets/SSH_KEY'

# Function to clone or pull a repository
clone_or_pull() {
    local repo_url=$1
    local clone_dir=$2

    if [ -d "$clone_dir" ]; then
        echo "Directory $clone_dir exists. Performing git pull."
        GIT_SSH_COMMAND="$GIT_SSH_COMMAND" git -C "$clone_dir" pull
    else
        echo "Directory $clone_dir does not exist. Performing git clone."
        GIT_SSH_COMMAND="$GIT_SSH_COMMAND" git clone "$repo_url" "$clone_dir"
    fi
}

# Repositories and their target directories
clone_or_pull "git@github.com:mt-climate-office/mesonet-ln-software" "/opt/mesonet-ln-software"

# Clone private repositories
check_compile.sh /opt/check_compile
chmod +x /opt/check_compile
ln -s /opt/check_compile /usr/local/bin/check_compile

sleep infinity