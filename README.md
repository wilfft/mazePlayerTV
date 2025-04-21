# TVMazeApp Documentation

## Table of Contents
- [Overview](#overview)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Features](#features)
  - [Authentication](#authentication)
  - [Shows Browsing](#shows-browsing)
  - [Favorites](#favorites)
  - [People Search](#people-search)
- [Core Components](#core-components)
  - [Networking](#networking)
  - [Services](#services)
  - [Extensions](#extensions)
- [Screens](#screens)
- [Security](#security)
- [Installation and Setup](#installation-and-setup)
- [Dependencies](#dependencies)

## Overview

TVMazeApp is an iOS application built with SwiftUI that provides a user-friendly interface to explore TV shows and actors using the TVMaze API. The app offers features such as browsing shows, saving favorites, searching for actors, and viewing detailed information about shows and episodes.

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Models**: Data structures representing entities like shows, episodes, and people
- **Views**: SwiftUI views responsible for UI rendering
- **ViewModels**: Classes that manage the business logic and state for views
- **Services**: Dedicated components handling API requests, data persistence, and other functionalities

The app also implements a coordinator pattern through `AppCoordinator` to manage navigation and authentication flow.

## Project Structure

```
TVMazeApp/
  ├── App/
  │   ├── TVMazeApp.swift          # Main app entry point
  │   ├── AppCoordinator.swift     # App navigation and state management
  │   └── SecurityService.swift    # Authentication management
  │
  ├── Core/
  │   ├── Network/                 # Networking components
  │   │   ├── APIClient.swift      # Generic API client
  │   │   ├── APIError.swift       # API error handling
  │   │   └── Endpoint.swift       # API endpoints definition
  │   │
  │   └── Extensions/              # Swift extensions
  │       ├── View+Extensions.swift
  │       ├── Date+Extensions.swift
  │       ├── Color+Extensions.swift
  │       └── String+Extensions.swift
  │
  ├── Features/
  │   ├── Authentication/          # User authentication
  │   │   ├── Models/
  │   │   ├── ViewModels/
  │   │   └── Views/
  │   │
  │   ├── Shows/                   # TV shows browsing
  │   │   ├── Models/
  │   │   ├── ViewModels/
  │   │   └── Views/
  │   │
  │   └── People/                  # Actors search
  │       ├── Models/
  │       ├── ViewModels/
  │       └── Views/
  │
  └── Services/                    # App services
      ├── TVMazeService.swift      # API service
      ├── ImageCacheService.swift  # Image caching
      ├── FavoritesService.swift   # Favorites management
      ├── LocalStorageService.swift # Data persistence
      └── BiometricService.swift   # Biometric authentication
```

## Features

### Authentication

The app implements a secure authentication system:

- **PIN Setup**: First-time users can create a 4-digit PIN for app access
- **Biometric Authentication**: Support for Face ID or Touch ID as an alternative authentication method
- **Security Service**: Manages the authentication state throughout the app

#### Key Components:
- `SecurityService`: Handles PIN verification and biometric authentication
- `AuthenticationView`: Main screen for authentication
- `PINSetupView`: Allows users to set up their PIN
- `BiometricService`: Manages Face ID and Touch ID authentication

### Shows Browsing

Users can browse and search for TV shows:

- **Shows List**: Display shows in a grid layout with infinite scrolling
- **Show Details**: View comprehensive information about a selected show
- **Episodes**: Browse episodes organized by seasons
- **Episode Details**: Access detailed information about specific episodes
- **Search**: Search functionality for finding shows by name

#### Key Components:
- `ShowsListView` & `ShowsListViewModel`: Main shows browsing interface
- `ShowDetailView` & `ShowDetailViewModel`: Show details screen
- `EpisodeDetailView` & `EpisodeDetailViewModel`: Episode details screen
- `ShowCardView`: Reusable component for displaying show cards

### Favorites

Users can save and manage their favorite shows:

- **Save Favorites**: Ability to mark shows as favorites
- **Favorites List**: View and manage all saved favorites
- **Persistence**: Favorites are stored locally for offline access

#### Key Components:
- `FavoritesView` & `FavoritesViewModel`: Interface for viewing and managing favorites
- `FavoritesService`: Manages favorites data and persistence

### People Search

Find and explore information about actors:

- **People Search**: Search for actors by name
- **Person Details**: View information about a specific actor
- **Actor's Shows**: Browse shows featuring the selected actor

#### Key Components:
- `PeopleSearchView` & `PeopleSearchViewModel`: Interface for searching people
- `PersonDetailView` & `PersonDetailViewModel`: Person details screen
- `PersonCardView`: Reusable component for displaying person cards

## Core Components

### Networking

The networking layer is responsible for API communication:

- **APIClient**: Generic client for API requests
- **Endpoint**: Structure representing TVMaze API endpoints
- **APIError**: Error handling for network requests

```swift
class APIClient {
    // Makes type-safe API requests and handles responses
    func fetch<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, APIError>
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
    var url: URL? // Builds the complete URL
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError(Error)
    case unknown(Error)
}
```

### Services

Services handle specific functionalities:

- **TVMazeService**: Interfaces with the TVMaze API
- **ImageCacheService**: Caches images for better performance
- **FavoritesService**: Manages user's favorite shows
- **LocalStorageService**: Handles local data persistence
- **BiometricService**: Manages biometric authentication
- **SecurityService**: Handles app security and authentication

### Extensions

Extensions enhance existing Swift types:

- **View+Extensions**: Adds additional functionality to SwiftUI views
- **Date+Extensions**: Date formatting utilities
- **Color+Extensions**: Custom colors and color utilities
- **String+Extensions**: String manipulation helpers

## Screens

### Main Screens:
1. **Authentication Screen**: PIN entry or biometric authentication
2. **Shows List**: Grid view of available shows with search functionality
3. **Show Details**: Detailed information about a selected show
4. **Episode Details**: Information about specific episodes
5. **Favorites**: List of user's favorite shows
6. **People Search**: Search interface for finding actors
7. **Person Details**: Information about selected actors and their shows

### Main Tab Navigation:
The app uses a tab bar for main navigation:
- Shows tab
- Favorites tab
- People search tab

## Security

The app implements several security features:

- **PIN Protection**: Optional 4-digit PIN for app access
- **Biometric Authentication**: Support for Face ID and Touch ID
- **Secure Storage**: Sensitive data is stored securely using UserDefaults (Note: For a production app, consider using Keychain for stronger security)

## Installation and Setup

1. Clone the repository
2. Open the project in Xcode
3. Build and run the app on a simulator or physical device

## Dependencies

The app uses native Apple frameworks and has no external dependencies:
- SwiftUI
- Combine
- Foundation
- LocalAuthentication

All network requests, image caching, and data persistence are implemented using native iOS capabilities.

App running...




