## EIDA Technical Assessment - Task: Build a SpaceX Launch App

## Provide the source code along with clear instructions on how to build and run the app

This project uses the latest Xcode version (15.2) and has no external dependancies. You should be able to download and run this project using Xcode with no issues or additional setup.

## Include a brief document explaining the design decisions and any challenges faced during the development process

### UI

This app was built using SwiftUI. I went with SwiftUI as it's a great way to get a small App up and running. Generally that was going fine, until my SwiftUI Canvas crashed and I could no longer use SwiftUI Preview, which slowed down the process considerably.

In terms of UI design, I tried to keep the design true to Apple's HIG so it would feel like a native App, whilst also adding some nice design elements, like the Launch Team badge being really front and center on the Launch Details screen. 

The app fully supports Light and Dark Mode as it's built with SwiftUI.

### Architecture

Went with a Simple MVVM app with a Router. I think adding SwiftUI made the Router a bit non standard (as the router generally wouldn't return a View), but it's still nice to have that routing logic separated from the View and View Model.
The architecture of the LaunchDetails screen is sightly different as it uses SwiftData's @Model attribute to power the view. 

### Storage

Used SwiftData as the persistence layer. I was going to just cache the raw JSON as a string to disk, but I wanted to try out SwiftData -> SwiftUI which works really well. After the inital setup it's trivial to get UI elements from cache to UI. 

### Testing

I added some simple Tests for Webservice and LaunchesViewModel. The LaunchesViewModel ones are more interesting and they test the core flow of the View Model, to make sure everything is wired up correctly. This was made possible by injecting the services for the View Model so we could inject mocks.

### Challenges

The main challenge here (aside from time) was getting SwiftData to work (as I had never used it before), I had some initial issues with it and it tured out to be a misconfiguration.

## Requirements:

### 1 - Integration: ✅

Integrate the app with the following API : api.spacexdata.com

Documentation available on https://github.com/r-spacex/SpaceX-API

### 2 & 3 - User UI: Launch Data ✅

- Create an iOS app that provides information about SpaceX launches

- Design a user-friendly interface with at least two screens: 
- (1) showing the upcoming and past launches 
- Display information about past and upcoming launches, including the mission name, launch date, and success status If the mission fails, display the reason why it fails
- *Display the local date and the corresponding irish date

_NOTE: This API doesn't seem to return future launches._

<img src="https://github.com/chillok/EIDASpaceX/assets/1297482/924f6397-1817-4144-bf9a-ed2495a30ff2" width="250">

### 2 & 3 - User UI: Launch Details ✅

- Create an iOS app that provides information about SpaceX launches

- Design a user-friendly interface with at least two screens: 
- (2) Launches details
- Implement a feature to view detailed information about a specific launch when selected
- Include additional details such as rocket details and pictures, crew

<img src="https://github.com/chillok/EIDASpaceX/assets/1297482/703971d9-456a-468b-bb56-8fb5b8bf5062" width="250">
<img src="https://github.com/chillok/EIDASpaceX/assets/1297482/fb452161-e80f-4aaa-92eb-1b09ff914f04" width="250">

### 5 - Data Persistence: ✅
- Implement local data caching to store the showing data
- This data needs to be accessible when the device is offline

This project uses SwiftData as the persistence layer.

### 6 - Error Handling: ✅
- Implement proper error handling for network requests.
- Provide user-friendly error messages.

Each time the App launches, we will try and load from cache first and network after. If we have nothing in the cache and we fail to load from Network, we'll show an error. Otherwise we'll silently use cache data.

<img src="https://github.com/chillok/EIDASpaceX/assets/1297482/e9f0f3f0-f837-4f73-88e5-ca2dfc46f3c3" width="250">

Note that I used a different system on the LaunchDetails to demonstrate SwiftData's @Model usage and it does not have retry functionality built in. I would follow a similar system the LaunchesViewModel on this if I had time.

### 7 - Code Quality: ✅
- Write clean, modular, and maintainable code.
- Use Swift best practices and adhere to the MVC or MVVM design pattern

This project uses MVVM pattern with a Router for navigation.

Each component has a protocol (eg Webservice, Router, Storage) and is injected into the ViewModel.

The `LaunchesViewModel` follows a standard pattern where our view notifies its ViewModel it has launched and would like data, and our view's UI elements are binded to the ViewModel, so when it receives data the View is automatically updated.

The `LaunchDetailViewModel` is still MVVM, but we use the new `@Query` attribute for the Model Data. This automatically fetches the data for our View. I added this just as a sample of the new SwiftData APIs. The one drawback here is that it's not as nice to add error handling, we'd still need to add some work in the ViewModel to manage that.

### 8 - Testing: ✅

- Added Unit Tests for the `Webservice` decoding, where we mock the `URLSession` bit and return local JSON from disk.
- Added Integration Tests for our `LaunchDetailViewModel` as I think these flow tests are really important. Because I added interfaces to all our services (Router, Webservice, Storage), I can then mock them and use the real `LaunchDetailViewModel`.
- Then we can call any function on the View Model and guarentee the correct outcome still happens, eg when I call `retrieveLaunches()` on the View Model, the webservice and storage are correctly called.

- ## * Bonus: Support both light and dark mode.

<img src="https://github.com/chillok/EIDASpaceX/assets/1297482/a4a118ca-4a82-4b44-a47e-a761c4998b13" width="250">
<img src="https://github.com/chillok/EIDASpaceX/assets/1297482/6756ee0a-97d6-495d-a29a-2f4265a9850b" width="250">
<img src="https://github.com/chillok/EIDASpaceX/assets/1297482/64ef3d55-d735-44c9-b973-b49cc524a81b" width="250">
<img src="https://github.com/chillok/EIDASpaceX/assets/1297482/3032e561-e9f9-4918-a742-e2e314fdbf82" width="250">

- ## * Bonus: Added Search and Filtering
<img src="https://github.com/chillok/EIDASpaceX/assets/1297482/ce71b16c-7ece-4be8-9396-69e608eaafa4" width="250">
<img src="https://github.com/chillok/EIDASpaceX/assets/1297482/586e499e-bb62-4f7e-8b89-b737c6f4cff4" width="250">

