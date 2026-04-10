# SkinCheck AI

AI-powered skin analysis app. Take a selfie, get AI-driven analysis across 7 facial zones, receive personalized skincare routines and product recommendations.

## Features

- **AI Skin Analysis** — GPT-4o Vision analyzes 7 facial zones, provides 0-100 score
- **Personalized Routines** — Morning/evening skincare routines tailored to your skin type
- **Progress Tracking** — Track skin improvements over time with charts
- **Product Recommendations** — AI-matched product suggestions for your concerns
- **Skin Age Estimation** — Discover your skin's real age
- **Share Results** — Share analysis cards with friends
- **Freemium Model** — Free tier with daily analysis, Pro for unlimited access

## Tech Stack

- **Frontend:** Flutter 3.x (iOS, Android, Web)
- **Backend:** Supabase (Auth, PostgreSQL, Storage, Edge Functions)
- **AI:** GPT-4o Vision via Supabase Edge Functions
- **State:** Riverpod 2.x with code generation
- **Navigation:** GoRouter
- **Payments:** RevenueCat
- **Face Detection:** Google ML Kit (on-device)

## Getting Started

### Prerequisites

- Flutter SDK 3.9+
- Dart SDK 3.9+
- Supabase project (for backend)
- Xcode (for iOS)
- Android Studio (for Android)

### Setup

```bash
# Clone the repository
git clone https://github.com/erenkara1907/skincheck-ai.git
cd skincheck-ai

# Create environment file
cp .env.example .env
# Fill in your Supabase URL and anon key

# Install dependencies
flutter pub get

# Generate code (Freezed, Riverpod, JSON serialization)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Build

```bash
# Web
flutter build web --release

# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## Architecture

Feature-first Clean Architecture with domain/data/presentation layers per feature. See `.claude/CLAUDE.md` for full architecture documentation.

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## License

All rights reserved.
