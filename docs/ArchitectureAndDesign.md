
## Architecture and Design

The app uses Firebase for the backend, Google API for Geocoding, Geolocation, and Static Maps. Within Firebase we use Cloud Functions for server-side notification logic, Cloud Messaging to send push notifications to users, a Real-time database for the real-time messaging system and Firestore to store all app wide data.


## Logical Architecture
 <p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2022-23/2LEIC03T5/blob/main/images/logical_larch.drawio-3.png"/>
</p>

## Physical Architecture 
The client devices communicate with the backend servers through the internet. The backend servers communicate with the Google API servers to retrieve information such as maps and location data and Firebase as the database.
 <p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2022-23/2LEIC03T5/blob/main/images/PhysicalArchitecture.png"/>
</p>

