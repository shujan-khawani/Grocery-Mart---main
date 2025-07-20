# Technical Decisions

## 1. State Management
- **Provider** pattern is used for state management (via `ChangeNotifier` and `MultiProvider`).
  - *Rationale*: Official Flutter recommendation, simple for moderate complexity, fast prototyping, and strong community support.

## 2. Persistence & Local Storage
- **SharedPreferences** is used for persisting cart and favorites data.
  - *Rationale*: Lightweight, no database overhead, fits simple key-value storage needs for this app.

## 3. Navigation
- **Bottom Navigation Bar** with `IndexedStack` is used to maintain state across tabs.
  - *Rationale*: Standard for e-commerce, preserves screen state, improves performance and UX.
- **Custom route transitions** are implemented for smooth navigation.

## 4. Project Structure
- Modular separation: `controllers/`, `models/`, `services/`, `utils/`, `views/`.
  - *Rationale*: Promotes maintainability, scalability, and separation of concerns.

## 5. UI/UX Framework
- **Material Design** with custom theming (green primary color, Google Fonts).
  - *Rationale*: Familiar, modern, and consistent user experience; easy customization.

## 6. Data Handling
- Product and category data are statically defined in code (no backend/API).
  - *Rationale*: Simplifies demo/assessment scope, avoids unnecessary complexity.

## 7. Dependency Choices
- Only essential packages included: `provider`, `shared_preferences`, `google_nav_bar`, `carousel_slider`, `google_fonts`, `collection`.
  - *Rationale*: Minimize bloat, focus on core functionality, and maintain fast build times.

## 8. Testing Approach
- Structure supports both unit and integration testing (see README for scenarios).
  - *Rationale*: Ensures code reliability and maintainability.

## 9. Future Considerations
- Architecture allows for easy integration of backend APIs, advanced auth, and remote storage if needed.

---
*This document summarizes only the technical and architectural decisions, not feature lists or user flows.*
