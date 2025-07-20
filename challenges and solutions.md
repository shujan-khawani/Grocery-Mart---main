# Challenges and Solutions

## 1. Static Data Limitation
**Challenge:**
The application uses hardcoded product and category data, which restricts scalability and real-world applicability.

**Solution:**
The codebase is structured to allow easy integration of backend APIs or remote databases in the future, minimizing refactoring when scaling up.

---

## 2. State Persistence Across Sessions
**Challenge:**
Ensuring that cart and favorites data persist reliably across app restarts without introducing unnecessary complexity.

**Solution:**
Utilized `SharedPreferences` for lightweight, key-value storage, which is efficient for the app’s current needs and avoids the overhead of a full database solution.

---

## 3. State Management and UI Consistency
**Challenge:**
Managing state across multiple features (cart, products, navigation, favorites) while keeping the UI responsive and consistent.

**Solution:**
Adopted the `Provider` pattern with dedicated controllers for each domain, ensuring clear separation of concerns and scalable state management.
