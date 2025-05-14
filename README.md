# 📖 Blog App

A feature-rich, cleanly structured **Blog App** built with **Flutter**, using **Supabase** as the backend and applying **Clean Architecture** principles. The app allows users to browse, search, create, and manage blogs, while handling user authentication and settings — all powered by cloud services without local storage.

---

## 🚀 Overview

This app provides a smooth blogging experience, including:

- Secure user authentication
- Blog creation and pagination
- Blog search and filtering
- Favorite blog tracking
- Custom user settings (theme, language, profile)
- Fully cloud-based with **Supabase**
- State management via **Flutter Bloc**

---

## ✨ Key Features

### 🔐 Authentication
- **Login**: Existing users can securely sign in using email and password.
- **Register**: New users can create an account.
- **Session Management**: Persistent login using Supabase Auth.

---

### 🧭 Navigation (Bottom Navigation Bar)
The app uses a **Bottom Navigation Bar** with four main sections:

#### 🏠 Main Page (All Blogs)
- Displays all available blogs fetched from Supabase.
- **Infinite scroll with pagination** — loads more blogs as the user scrolls.
- **Floating Action Button (FAB)** to add a new blog post with:
    - Title input
    - Content editor
    - Image upload support

#### 🔍 Search Page
- Search for blogs by **title** or **keywords** in content.
- Instant feedback with live filtering.

#### ❤️ Favorite Page
- Displays blogs the current logged-in user has **marked as favorite**.
- Supports toggling favorite status.
- Data fetched from Supabase – no local storage involved.

#### ⚙️ Settings Page
Customize the app experience with:
- **Profile Page**: View and update user details.
- **Change Password**
- **Change Language** (localized with Flutter `intl`)
- **Change Theme** (light/dark)
- **About App**
- **Rate Us**
- **Logout**

---

## 🏛️ Clean Architecture

The app follows **Clean Architecture** with well-separated layers:

- **Presentation Layer**
    - UI and Bloc-based state management.
- **Domain Layer**
    - Business logic and use cases.
- **Data Layer**
    - Integration with Supabase APIs.
    - No local database – real-time data from cloud only.

---

## ⚙️ Tech Stack

| Technology    | Purpose                          |
|---------------|----------------------------------|
| **Flutter**   | Cross-platform mobile framework  |
| **Dart**      | Programming language             |
| **Supabase**  | Backend (Auth, DB, Storage)      |
| **Bloc**      | State management                 |
| **Intl**      | Localization                     |
| **Cloud only**| No local database used           |

---

## 🖼️ App Previews

### 🏠 Home Page – Paginated Blog List
> Infinite scroll loading more blogs from Supabase.

![Home Page Demo](assets/images/home_demo.gif)

---

### ➕ Add Blog – Blog Creation
> Create a new blog post with image, title, and content.

![Add Blog Demo](assets/images/add_blog_demo.gif)

---

### ❤️ Favorites – Saved Blogs
> Favorite list stored and fetched per user.

![Favorites Demo](assets/images/favorites_demo.gif)

---

### ⚙️ Settings – Full Customization
> Update profile, theme, language, and app preferences.

![Settings Page Demo](assets/images/settings_demo.gif)

---

## 🛠️ Getting Started

### 1️⃣ Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Supabase Account](https://supabase.com/)
- An IDE like VSCode or Android Studio

---

### 2️⃣ Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/blog_app.git
cd blog_app

# Install dependencies
flutter pub get

# Run the app
flutter run
