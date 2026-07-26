#!/bin/bash
set -e

FLUTTER_HOME="$HOME/flutter-sdk"

if [ ! -d "$FLUTTER_HOME" ]; then
  echo "=== Cloning Flutter SDK ==="
  git clone https://github.com/flutter/flutter.git "$FLUTTER_HOME" --depth 1 -b stable
else
  echo "=== Using cached Flutter SDK ==="
fi

export PATH="$FLUTTER_HOME/bin:$PATH"

echo "=== Flutter version ==="
flutter --version

echo "=== Getting dependencies ==="
flutter pub get

echo "=== Building web ==="
flutter build web --release --base-href / --no-tree-shake-icons 2>&1

echo "=== Build output ==="
ls -la build/web/
