# VIPER Architecture iOS Project

This project demonstrates the **VIPER Architecture** that combines **SwiftUI** and **UIKit**.  
It was developed step-by-step, starting from a simple login flow and progressively adding features like registration and API integration.  

---

## Project Explanation

The project simulates a simple authentication and dashboard system using VIPER architecture:

- The **Login screen** validates users with predefined credentials.
- The **Register screen** allows new users to register and saves their data locally using "UserDefaults".
- The **Dashboard** displays random images fetched from a public API using async/await networking.

Each layer has its own responsibility — ensuring that logic, data, and UI are completely separated.

---

## Working of the Project

### Flow Overview

1. **Launch App → Login Screen**
   - The user enters email and password.
   - If credentials match, they’re redirected to the Dashboard.
   - If not registered, they can tap **Register** to sign up.

2. **Register Screen**
   - User enters a new email and password.
   - Data is saved to "UserDefaults".
   - If already registered, a message is shown.
   - After successful registration, user returns to Login.

3. **Dashboard**
   - Displays “Welcome to Dashboard” (in Phase 1).
   - Later updated to fetch and display **random images** from an API.
   - Uses **async/await** and a **NetworkHandler** to manage data fetching.

---

## Screenshots & UI Flow

### Login Screen
<img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-10 at 12.53.02.png" width="300"/>

The app starts at the Login screen.  
Users enter their **email** and **password** — if valid, they’re redirected to the Dashboard using "UIHostingController" (SwiftUI inside UIKit).

---

### Registration Screen
<img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-10 at 12.54.55.png" width="300"/>

Users who don’t have an account can tap **Register**, enter their credentials, and save them to "UserDefaults".  
If the email already exists, a validation message appears.

---

### Registration Success
<img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-10 at 12.55.29.png" width="300"/>

After registering successfully, the app navigates back to the **Login screen**, where the user can now log in.

---

### Invalid Credentials Message
<img src="Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202025-11-10%20at%2012.55.47.png" width="300"/>

If incorrect credentials are entered, the app displays an “Invalid credentials” alert message.

---

### Dashboard with Random Images
<img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-10 at 12.55.47.png" width="300"/>

Once logged in, the Dashboard displays a list of **random images** fetched from  
https://picsum.photos/v2/list?page=4&limit=15.  
Each image shows the **author’s name** below it.  
The data flow here is handled entirely through VIPER modules and the **NetworkHandler**.


