Phase 1

- Created a Login screen that takes an email and password.
- Used hardcoded credentials in the code:
if email == "test@gmail.com" && password == "123456" {
    // Go to Dashboard
} else {
    // "Invalid credentials"
}

- When the correct details are entered, it moves to the Dashboard screen using UIHostingController (since SwiftUI pages are used inside UIKit).
- The Dashboard shows a simple message: “Welcome to Dashboard”.
- The project follows the VIPER architecture.
