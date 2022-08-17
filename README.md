# FireChat 🔥💬
Firechat is an instant messaging app developed by using SwiftUI framework. Fire chat allows you to send and receive text messages and photos. Also provides personal settings. 

## Screenshots 📱
To see the screenshot with more quality try to open png or open README file. 
![FireChatLast](https://user-images.githubusercontent.com/87194129/183529071-4b213aa7-9696-4800-a102-ebf9f705f01d.png)


## Project Features 
 - Instant messaging
 - Support Text & Image Types
 - Dark Mode Support
 - Keep Favorite Messages
 - Clean UI
 - Create & Delete Account
 - Status Selection
## Dependency
 - Firebase (Auth, Firestore, Storage, FirebaseFirestoreSwift) [Docs](https://firebase.google.com/docs/ios/setup)
 - SDWebImageSwiftUI [Library Link](https://github.com/SDWebImage/SDWebImageSwiftUI)
## Getting Started ⚒
 - Clone this repository.


```bash
git clone https://github.com/alpsudilbilir/fire-chat.git
```
 - Change the bundle identifier.

 - Go to [Firebase](https://firebase.google.com/) and create new project
 - Get the  [GoogleService-Info.plist](https://support.google.com/firebase/answer/7015592#zippy=%2Cin-this-article) file from Firebase
 - Go to the [Firebase Console](https://console.firebase.google.com/) and enable Authenticaton, Storage and Firestore for your project. (For authentication only enable Email/Password for SIGN-IN METHOD)
 - Add SDWebImageSwiftUI package from [here](https://github.com/SDWebImage/SDWebImageSwiftUI).
 - Run the project. 

## Project Structure 🦚

```swift
├── FireChatApp.swift
├── ContentView.swift
├── Models
│   ├── ChatMessage.swift
│   ├── FavoriteMessage.swift
│   ├── RecentMessage.swift
│   └── User.swift
└── Service
│   └── UserDefaultService.swift
├── Extensions
│   ├── ColorExtensions.swift
│   └── ViewExtensions.swift
├── Helpers
│   └── ImagePicker.swift
├── Network
│   └── FireBaseManager.swift
├── Screens
│   ├── ChatScreen
│   │   ├── ChatScreen.swift
│   │   ├── ChatScreenViewModel.swift
│   │   └── MessageCell.swift
│   ├── LoginRegisterScreens
│   │   ├── LoginRegisterScreen.swift
│   │   ├── LoginRegisterSubItems
│   │   │   ├── CustomSecureField.swift
│   │   │   └── CustomTextField.swift
│   │   ├── LoginScreen.swift
│   │   └── RegisterScreen.swift
│   ├── MainMessageScreen
│   │   ├── CustomNavBar.swift
│   │   ├── MainMessagesScreen.swift
│   │   ├── MainMessagesViewModel.swift
│   │   └── MessageItem.swift
│   ├── NewMessageScreen
│   │   ├── NewMessageScreen.swift
│   │   └── NewMessageScreenViewModel.swift
│   └── Profile Screen
│       ├── FavoriteMessagesScreen.swift
│       ├── PhotoScreen.swift
│       ├── ProfileScreen.swift
│       ├── ProfileScreenViewModel.swift
│       └── SettingsListView.swift
├── Assets.xcassets
├── GoogleService-Info.plist
├── Preview Content
├── README.md




```

## Contributing
Pull requests are welcome.


## License
```
MIT License

Copyright (c) [year] [fullname]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
