#!/bin/bash

# Build the package
flutter pub get && flutter packages pub publish --dry-run

# Get the version number and package name from pubspec.yaml
name=$(grep -m1 'name:' pubspec.yaml | sed 's/name: \+//')
version=$(grep -m1 'version:' pubspec.yaml | sed 's/version: \+//')

# Remove unwanted strings
version=${version//version: /}
name=${name//name: /}

# Create a .tar.gz file excluding certain directories
tar --exclude='.dart_tool' --exclude='example' --exclude='examples/master_app' -czf $name-$version.tar.gz ./*

# Create a new virtual environment if it doesn't exist
if [ ! -d "$HOME/cloudsmith-cli-venv" ]; then
  echo "Creating a new virtual environment..."
  python3 -m venv $HOME/cloudsmith-cli-venv
fi

# Activate the virtual environment
echo "Activating the virtual environment..."
source $HOME/cloudsmith-cli-venv/bin/activate

# Check if cloudsmith-cli is installed
if ! [ -x "$(command -v cloudsmith)" ]; then
  echo "Installing Cloudsmith CLI..."
  pip3 install cloudsmith-cli
fi

# Check if the user is logged in
if ! cloudsmith whoami > /dev/null; then
  echo "Logging in to Cloudsmith..."
  cloudsmith token
fi

echo "Publishing: $name-$version.tar.gz"

# Publish the package to cloudsmith
cloudsmith push dart cometchat/call-team $name-$version.tar.gz

# Remove tar file once upload is complete
rm ./"$name-$version.tar.gz"
