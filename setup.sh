#!/bin/bash

echo "Installing dependencies..."
flutter pub get

echo "Generating code with build_runner..."
flutter pub run build_runner build --delete-conflicting-outputs

echo "Setup complete!"
echo "You can now run the app with 'flutter run -d chrome' (or your preferred platform)" 