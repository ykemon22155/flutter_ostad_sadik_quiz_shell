# Firebase & Google Sign-In Setup Guide

To complete the implementation of Google Sign-In in this project, you must perform the following manual steps:

## 1. Firebase Project Setup
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project (or use an existing one).
3. Add an **Android App** to the project.
   - **Package Name:** `com.example.quiz_shell` (Verified from `build.gradle.kts`).
4. Download the `google-services.json` file.
5. **Move the file to:** `android/app/google-services.json`.

## 2. SHA-1 Fingerprint (Required for Google Sign-In)
Google Sign-In will fail with an error if the SHA-1 fingerprint is not registered in Firebase.
1. Open your terminal in the project root.
2. Run the following command:
   ```bash
   cd android
   ./gradlew signingReport
   ```
3. Look for the `debug` variant in the output and copy the **SHA-1** hex string.
4. Go to **Firebase Project Settings** > **General** > **Your Apps**.
5. Paste the SHA-1 into the "SHA certificate fingerprints" section for your Android app.

## 3. Enable Authentication Provider
1. In the Firebase Console, go to **Build** > **Authentication**.
2. Click the **Sign-in method** tab.
3. Click **Add new provider** and select **Google**.
4. Enable it, provide a project support email, and click **Save**.

## 4. Finalize Flutter Project
1. Run the following command in your terminal:
   ```bash
   flutter pub get
   ```
2. Run the app:
   ```bash
   flutter run
   ```

---
**Note:** If you are testing on a real device, ensure you have an active internet connection.
