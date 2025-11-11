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



## Screenshots & UI Flow

### Login Screen
<kbd><img src="Test_VIPER_Architecture_Project/Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-11 at 14.35.36.png" width="300"/></kbd>
<kbd><img src="Test_VIPER_Architecture_Project/Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-11 at 16.40.45.png" width="300"/></kbd>

---

### Registration Screen
<kbd><img src="Test_VIPER_Architecture_Project/Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-11 at 14.35.41.png" width="300"/></kbd>
<kbd><img src="Test_VIPER_Architecture_Project/Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-11 at 14.35.58.png" width="300"/></kbd>
<kbd><img src="Test_VIPER_Architecture_Project/Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-11 at 14.36.16.png" width="300"/></kbd>

---

### Registration Success
<kbd><img src="Test_VIPER_Architecture_Project/Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-11 at 14.36.56.png" width="300"/></kbd>
<kbd><img src="Test_VIPER_Architecture_Project/Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-11 at 14.37.18.png" width="300"/></kbd>


---

### UserDefaults (.plist File)
<kbd><img src="Test_VIPER_Architecture_Project/Screenshots/Screen Shot 2025-11-11 at 2.38.44 PM.png" width="600" height="400"/></kbd>

---

### Dashboard with Random Images
<kbd><img src="Test_VIPER_Architecture_Project/Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-11 at 14.37.25.png" width="300"/></kbd>
<kbd><img src="Test_VIPER_Architecture_Project/Screenshots/Simulator Screen Shot - iPhone 13 - 2025-11-11 at 14.37.45.png" width="300"/></kbd>


