
# FirebaseProject

A social media application built with Swift and UIKit, designed for seamless interaction and robust features. Users can register, validate their email, log in, change passwords, post photos, comment on each other's posts, and download photos to their library.

## Features

- **User Registration**: Create a new account with email validation.
- **Login**: Secure login functionality with email and password.
- **Password Reset**: Change password feature in case the user forgets their current password.
- **Post Photos**: Upload photos to share with other users.
- **Commenting**: Comment on posts shared by others.
- **Download Photos**: Download photos and save them to the device library.
- **Firebase Integration**: Utilizing Firebase for authentication, database, and storage.
- **SnapKit for Constraints**: Programmatically setting up UI constraints using SnapKit.
- **Photos Framework**: Accessing and saving images to the user's photo library.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/omerkeskin98/FirebaseProject.git
   ```

2. Navigate to the project directory:
   ```bash
   cd FirebaseProject
   ```

3. Install dependencies using CocoaPods:
   ```bash
   pod install
   ```

4. Open the `.xcworkspace` file with Xcode:
   ```bash
   open FirebaseProject.xcworkspace
   ```

## Setup

1. **Firebase Configuration**:
   - Create a new project on the [Firebase Console](https://console.firebase.google.com/).
   - Add an iOS app to your Firebase project.
   - Download the `GoogleService-Info.plist` file and add it to your Xcode project.

2. **Enable Authentication**:
   - In the Firebase Console, navigate to the Authentication section.
   - Enable Email/Password authentication.

3. **Setup Firestore**:
   - In the Firebase Console, navigate to the Firestore Database section.
   - Create a new database and start in test mode (you can configure rules later for production).

4. **Enable Firebase Storage**:
   - In the Firebase Console, navigate to the Storage section.
   - Set up your storage bucket.

## Usage

- **Register**: Users can register with their email and password. They will receive an email to validate their account.
- **Login**: Users can log in with their registered email and password.
- **Password Reset**: Users can request a password reset link via email if they forget their password.
- **Post Photos**: Users can upload photos to share with others.
- **Commenting**: Users can comment on photos posted by others.
- **Download Photos**: Users can download photos to their device's photo library.



## Acknowledgements

- [Firebase](https://firebase.google.com/) for backend services.
- [SnapKit](https://github.com/SnapKit/SnapKit) for constraints.
- [Photos Framework](https://developer.apple.com/documentation/photokit) for photo library integration.

## Images
<img width="493" alt="Screenshot 2024-08-05 at 11 35 28" src="https://github.com/user-attachments/assets/94857c1d-7a17-4890-97b1-ec876b8c17d2">
<img width="493" alt="Screenshot 2024-08-05 at 11 35 39" src="https://github.com/user-attachments/assets/232c00fb-b6f0-4752-89a2-7b26de21aa50">
<img width="493" alt="Screenshot 2024-08-05 at 11 35 46" src="https://github.com/user-attachments/assets/8dd1cfd8-4079-480c-a9ef-c9ae89bb1145">
<img width="493" alt="Screenshot 2024-08-05 at 11 35 52" src="https://github.com/user-attachments/assets/3822f10f-0ef7-4415-abf1-715f9b270f50">
<img width="493" alt="Screenshot 2024-08-05 at 11 35 58" src="https://github.com/user-attachments/assets/b8582fe3-2023-4881-8988-f3dd73d22ff9">



