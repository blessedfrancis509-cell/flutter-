#!/bin/bash
set -e

# Install Flutter SDK
if [ ! -d "$HOME/flutter" ]; then
  echo "Installing Flutter SDK..."
  git clone https://github.com/flutter/flutter.git "$HOME/flutter" --depth 1 -b stable
fi

export PATH="$HOME/flutter/bin:$PATH"

echo "Flutter version:"
flutter --version

echo "Getting dependencies..."
flutter pub get

echo "Building for web..."
flutter build web --release --base-href /

echo "Build complete!"
ls -la build/web/
