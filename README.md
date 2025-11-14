# VIPER Architecture iOS Project

This project demonstrates the **VIPER Architecture** that combines **SwiftUI** and **UIKit**.  

## Project Explanation

The project simulates a simple authentication and dashboard system using VIPER architecture:

- The **Login screen** validates users with credentials.
- The **Register screen** allows new users to register and saves their data locally using "UserDefaults".
- The **Dashboard** displays random images fetched from a public API.

Each layer(VIPER) of Project has its own responsibility — ensuring that logic, data, and UI are completely separated.


## Working of the Project

### Flow Overview

1. **Login Screen**
- The screen takes **Email** and **Password** as input.  
- On pressing **Login**, it checks if the entered credentials match any user stored in **UserDefaults**.
  - If credentials are correct → navigates to the **Dashboard Screen**.  
  - If not → shows an alert saying **“Invalid credentials”**.
- Navigation is handled using **UIHostingController** because SwiftUI pages are used inside UIKit.


2. **Register Screen**
- The user enters their **Email** and **Password** in text fields.  
- On pressing the **Register** button:
  - The app checks if the email already exists in **UserDefaults** (under the key "registeredUsers").  
  - If it doesn’t exist:
    - A new user is created as an "Entity" struct ("email", "password").  
    - The user list is updated and stored back into "UserDefaults".  
    - A success message is shown, and the user is navigated back to the **Login screen**.  
  - If it already exists, it shows a message **“User Already Exists”** and registration fails.  


3. **Dashboard**
- After logging in successfully, the app navigates to the **Dashboard** using "UIHostingController", since SwiftUI screens are embedded inside UIKit.
- Once opened, the **DashboardPresenter** triggers a data fetch request.
- The **DashboardInteractor** calls the **NetworkHandler**, which fetches data from:
  - **API:** https://picsum.photos/v2/list?page=4&limit=15
- The fetched data is decoded into a model that includes:
  - Image URL  
  - Author Name
- The **Presenter** updates a "@Published" property, and the **View** automatically refreshes to show images with author names.



## Screenshots

### Login Screen
<kbd><img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-14 at 12.33.22.png" width="250"/></kbd>
<kbd><img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-14 at 12.33.37.png" width="250"/></kbd>
<kbd><img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-14 at 12.33.51.png" width="250"/></kbd>


---

### Registration Screen
<kbd><img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-14 at 12.34.20.png" width="180"/></kbd>
<kbd><img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-14 at 12.34.34.png" width="180"/></kbd>
<kbd><img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-14 at 12.35.15.png" width="180"/></kbd>
<kbd><img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-14 at 12.35.34.png" width="180"/></kbd>
<kbd><img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-14 at 12.35.52.png" width="180"/></kbd>

---

### Registration Success
<kbd><img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-14 at 12.36.08.png" width="250"/></kbd>


---

### UserDefaults (.plist File)
<kbd><img src="Screenshots/Screen Shot 2025-11-14 at 12.44.18 PM.png" width="600" height="400"/></kbd>

---

### Dashboard with Random Images
<kbd><img src="Screenshots/simulator_screenshot_09541C52-0C1D-493A-B22C-1C3BD95BA4C3.png" width="250"/></kbd>
<kbd><img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-14 at 12.37.01.png" width="250"/></kbd>
<kbd><img src="Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-14 at 12.57.03.png" width="250"/></kbd>


