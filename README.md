# Instagram Feed Clone (Flutter)

A simplified **Instagram Feed Clone** built with **Flutter**, focusing on performance, smooth UI interactions, and clean architecture.
The application replicates core feed behaviors such as **infinite scrolling, shimmer loading, pinch-to-zoom media, and interactive post actions**.

This project demonstrates practical Flutter concepts including **state management, efficient list rendering, asynchronous data loading, and UI animations**.

---

# Features

### 1. Infinite Scrolling Feed

* Posts are loaded **dynamically as the user scrolls**.
* Additional posts are fetched automatically when the user approaches the end of the feed.
* The implementation ensures **smooth scrolling without blocking the UI**.

---

### 2. Shimmer Loading Effect

While posts are loading, a **Shimmer placeholder UI** is displayed to simulate Instagram-like loading behavior.

This improves perceived performance and provides visual feedback while data is fetched.

---

### 3. Pinch-to-Zoom Interaction

Users can **pinch images to zoom in and out**, similar to Instagram.

Key behavior:

* Supports **zoom in/out gestures**
* Automatically **resets after release**
* Includes an **overlay effect for better focus**

---

### 4. Post Interactions

Users can interact with posts using the following actions:

* **Like** – Tap to like a post with a small animation.
* **Save** – Bookmark posts locally.
* **Comment / Share / Repost** – Currently show a placeholder ("Coming soon").

These interactions simulate basic social media engagement behavior.

---

### 5. Instagram-Style UI

The UI includes:

* Story section
* Instagram-style top app bar
* Post header (profile + audio label)
* Multi-image carousel posts
* Image counters and page indicators
* Bottom navigation bar

---

# State Management

This project uses **Provider** for state management.

### Why Provider?

Provider was chosen because it is:

* Lightweight and easy to integrate
* Officially recommended by the Flutter team
* Suitable for **small to medium sized applications**
* Efficient for **notifying UI updates**

### How it works in this project

The architecture includes:

**PostProvider**

* Manages application state
* Stores loaded posts
* Handles loading and refreshing
* Notifies UI when data changes

**PostRepository**

* Simulates API/network calls
* Generates post data
* Introduces artificial delay to mimic network latency

**UI Widgets**

* Subscribe to `PostProvider`
* Rebuild automatically when state updates

Architecture structure:

```
UI (Widgets)
   ↓
Provider (State Management)
   ↓
Repository (Data Source)
   ↓
Model (Post Data)
```

This separation keeps the code **modular, testable, and maintainable**.

---

# Project Structure

```
lib/
│
├── main.dart
│
├── models/
│   └── post_model.dart
│
├── providers/
│   └── post_provider.dart
│
├── services/
│   └── post_repository.dart
│
├── screens/
│   └── home_feed_screen.dart
│
└── widgets/
    ├── bottom_navigation_widget.dart
    ├── post_actions.dart
    ├── post_caption.dart
    ├── post_header.dart
    ├── post_media.dart
    ├── post_shimmer.dart
    ├── post_widget.dart
    ├── profile_circle.dart
    ├── story_circle_widget.dart
    └── your_story_widget.dart
```

---

# How to Run the Project

### 1. Clone the repository

```
git clone https://github.com/YOUR_USERNAME/instagram_feed_clone.git
```

### 2. Navigate into the project folder

```
cd instagram_feed_clone
```

### 3. Install dependencies

```
flutter pub get
```

### 4. Run the project

```
flutter run
```

Make sure you have a **Flutter SDK installed** and a **device or emulator running**.

---

# Demo Requirements

The demo video should showcase the following features:

### Shimmer Loading

Show the shimmer placeholder appearing while posts are loading.

### Smooth Infinite Scrolling

Scroll down the feed and demonstrate **new posts loading automatically**.

### Pinch-to-Zoom

Open a post image and perform the **pinch zoom gesture**.

### Toggle Interactions

Demonstrate:

* Like button animation
* Save bookmark toggle

---

# Dependencies Used

Main packages used in this project:

```
provider
cached_network_image
shimmer
pinch_zoom_release_unzoom
```

These packages help improve **performance, UX, and state management**.

---

# Performance Considerations

Several optimizations were implemented:

* `RepaintBoundary` used to isolate expensive widgets
* Image caching via `cached_network_image`
* Image preloading for smoother scrolling
* Efficient `SliverList` rendering
* Pagination to avoid loading large datasets

---

# Author

Pranay Das

Flutter Developer | Computer Science Student

---
