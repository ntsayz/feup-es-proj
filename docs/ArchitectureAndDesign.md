-
## Architecture and Design

This describes the architecture and design of an app that connects people who practice the same sport.The app uses Firebase for the backend, Google API for Geocoding, Geolocation, and Static Maps, Cloud Functions for server-side notification logic, Cloud Messaging to send push notifications to users, and a Real-time database for the real-time messaging system.

-
## Logical Architecture
The user interface is responsible for handling user input and displaying information to the user. The business logic contains the app's core functionality, such as creating events and inviting users. The data access layer is responsible for communicating with the app's backend and storing data.

[picture]()!
-
## Physical Architecture 
The client devices communicate with the backend servers through the internet. The backend servers communicate with the Google API servers to retrieve information such as maps and location data. The backend servers use Firebase for server-side notification logic and a Real-time database for the real-time messaging system.

[picture]()!
