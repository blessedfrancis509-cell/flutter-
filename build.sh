#!/bin/bash
set -e

# Use Netlify cache directory for Flutter SDK persistence
FLUTTER_HOME="${NETLIFY_CACHE_DIR}/flutter-sdk"

if [ ! -d "$FLUTTER_HOME" ]; then
  echo "=== Cloning Flutter SDK (cached) ==="
  git clone https://github.com/flutter/flutter.git "$FLUTTER_HOME" --depth 1 -b stable
else
  echo "=== Using cached Flutter SDK ==="
  cd "$FLUTTER_HOME"
  git pull --ff-only || true
  cd -
fi

export PATH="$FLUTTER_HOME/bin:$PATH"

echo "=== Flutter version ==="
flutter --version

echo "=== Cleaning previous builds ==="
flutter clean || true

echo "=== Getting dependencies ==="
flutter pub get

echo "=== Building web ==="
flutter build web --release --base-href / --no-tree-shake-icons 2>&1

echo "=== Build output ==="
ls -la build/web/
