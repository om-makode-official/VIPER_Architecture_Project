Phase 1

- Created a Login screen that takes an email and password
- Used hardcoded credentials in the code: <br>
if email == "test@gmail.com" && password == "123456" { <br>
    // Go to Dashboard <br>
} else { <br>
    // "Invalid credentials" <br>
} <br>

- When the correct details are entered, it moves to the Dashboard screen using UIHostingController (since SwiftUI pages are used inside UIKit)
- The Dashboard shows a simple message: “Welcome to Dashboard”




Phase 2 – User Registration

- In this phase, I added a Registration screen so new users can sign up and save their login details
- A Register button is added on the login page
- When you tap it, it opens a new screen with two text fields:
-- Enter Email
-- Enter Password
- After pressing the Register button, the app saves the user’s email and password in UserDefaults using the key "registeredUsers"
- If the email is already registered, it shows a message that the user already exists
