### Phase 1

- Created a Login screen that takes an email and password
- Used hardcoded credentials in the code: <br>
if email == "test@gmail.com" && password == "123456" { <br>
    // Go to Dashboard <br>
} else { <br>
    // "Invalid credentials" <br>
} <br>

- When the correct details are entered, it moves to the Dashboard screen using UIHostingController (since SwiftUI pages are used inside UIKit)
- The Dashboard shows a simple message: “Welcome to Dashboard”


<br><br><br><br>

### Phase 2 – User Registration

- In this phase, I added a Registration screen so new users can sign up and save their login details

- A Register button is added on the login page

- When you tap it, it opens a new screen with two text fields:
- Enter Email
- Enter Password
  
- After pressing the Register button, the app saves the user’s email and password in UserDefaults using the key "registeredUsers"
  
- If the email is already registered, it shows a message that the user already exists

<br><br>

VIPER Flow (Registration Module)

- RegisterView – Shows two TextField and Register button
- RegisterPresenter – Connects the View and Interactor. Sends user input to the Interactor and handles results
- RegisterInteractor – Handles the main logic, like checking if the user already exists and saving data to UserDefaults
- RegisterRouter – Manages navigation, After a successful registration, it goes back to the Login screen
- RegisterBuilder – Connects all VIPER parts together and build a view for Register Page

<br><br><br><br>

### Phase 3 – Dashboard Showing Random Images

In this phase, the Dashboard screen is updated
Before, it only shows a message “Welcome to Dashboard”
Now, it shows random images from an API "https://picsum.photos/v2/list?page=4&limit=15"
now it shows a list of images with author names

- Working
1. When the Dashboard opens, the Presenter tells the Interactor to get images
2. The Interactor calls the NetworkHandler which fetches the data from the API
3. Once data is received, the Presenter updates the images and the view shows images on screen
