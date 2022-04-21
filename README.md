# BonVoya App Design

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)

## Overview

### Description

This is an iOS application developed for iPhone that provides popular spots, activities, local news, etc. based on user input for location and dates of travel. Using this information, the user will then be able to create an itinerary, which allows for seamless planning and organization of activities and POIs related to a specific location where the user plans to travel.

### App Evaluation

- **Category:** Travel
- **Mobile:** This app will exclusively be developed and available for iPhone. Although it is possible to create a web-based version of this application, this app is designed to be a quick, easy, and user-friendly way to quickly make an itinerary and get information about certain locations at your fingertips. This app can also utilize your current location to find popular cities near you, if no preferred cities have been chosen.
- **Story:** Asks user for favorite travel locations and dates of travel, which will then be used to personalize a feed and dashboard with attractions for those locations and allow the user to create an itinerary and add favorite locations and preferred dates & times to that itinerary.
- **Market:** This app is mostly suited for those who travel, irrespective of how often or how little they travel. Additionally, users may just want to use the to find information about locations they are curious about.
- **Habit:** This app can be used as much or as little as the user likes, this depends on how much they travel and how often they’d like to retrieve personalized information about places that they find interesting.
- **Scope:** This app will require relatively 5-10 hours of work per week, per group member, in order to complete on time. We could always scale down or scale up, depending on how the development process is coming along. A stripped-down version of this app would definitely still be very interesting to build.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [ ] User can register and login
- [ ] User can specify their desired location(s) of travel
- [ ] A dashboard will display desired locations and current weather condition & temperature for each location
- [ ] User will be able to access a general news page that includes news for all of their locations
- [ ] When tapping on a location, user will be able to see a description, popular activities
- [ ] User will be able to create an itinerary
- [ ] User will be able to visit their profile and see their itineraries
- [ ] User can access a help bar item that helps them navigate through the app

**Optional Nice-to-have Stories**

- [ ] Dashboard will include a “spot of the day” for any of the locations they’ve specified
- [ ] User can log their travel items & packed luggage
- [ ] User will be able to see news for a specific location

### 2. Screen Archetypes
- [Login/Register]
    - [Login/Register will launch initially.]
- [Profile]
    - [User can access their saved plans and access settings.]
- [Creation]
   - [User can create a new trip from (+) bar.]
- [Settings]
    - [User can specify accessibility needs within the Profile tab.]

### 3. Navigation

**Tab Navigation** (Tab to Screen)

- [Profile]
- [(+)]
- [Dashboard]

**Flow Navigation** (Screen to Screen)

- [Profile]
    - [Settings]
    - [Plan#]
- [(+)]
    - [Filter -> TicketFinder]
- [Dashboard]
    - [Attractions]

## Wireframes
![Wireframe](https://user-images.githubusercontent.com/30938391/164106632-ca0ab42e-84e3-4cdc-a741-b10cb64044d4.jpeg)

## Schema 
### Models
#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| itinerary author |
   | image         | File     | image for corresponding location|
   | image         | File     | image for user Profile Picture|
   | itinerary     | JSON Object  | Itinerary object containing itinerary name, start date and end date |
   | itineraryPlace | Array  | User input for itinerary place item |
   | itineraryName | Pointer to Itinerary   | User input for itinerary name |
   | dateStart     | Pointer to Itinerary   | User input for itinerary start date |
   | dateEnd       | Pointer to Itinerary  | User input for itinerary start date |
   | createdAt     | DateTime | date when  is created (default field) |
### Networking
#### List of network requests by screen
   - Login/Register Screen
      - (Register/CREATE) Create a new account
         ```swift
           let query = PFQuery(classname: “Sign Up”)  
           let user = PFUser()
     	   user.username = usernameField.text
     	   user.password = passwordField.text
        
      	  user.signUpInBackground { (success, error) in
      	      if success {
       	         self.performSegue(withIdentifier: "loginSegue", sender: nil)
         	   } else {
           	     print("Error: \(error?.localizedDescription)")
           	 }
    	    }
         ```
      - Login (GET) Login into an existing account
        ```swift
            let query = PFQuery(classname: “Login”)  
          
            LoginAPI.login( success: {
          	    UserDefaults.standard.set(true, forKey: "userLoggedIn")
          	    self.performSegue(withIdentifier: "loginToHome", sender: self)
            
       		 }, failure: { (Error) in
     		   print("Could not login!")
     		 } 
        ```
   - Dashboard Screen
      - (Read/GET) Query to nearby attractions based on plan object 
        ```swift
            let query = PFQuery(className:"Dashboard")
            query.includeKeys(["attractions", "relativeLocation", "map", “weather])
            query.limit = 10
            query.findObjectsInBackground{ (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData() //reload the tableView
            }
        ```
       - (Update/PUT) current location set as default for finding attractions and allow selection between the locations of saved plans 
   - Profile Screen
      - (Read/GET) Query to access saved plans
        ```swift
           let query = PFQuery(classname: “Get Trips”)          
   	       numberofTrips = 5
   	       let myParams = ["count": 5]
        
     	   APICallers.getDictionariesRequest(url: myUrl, parameters: myParams) { (Trips: [Dictionary]) in
      	      self.TripArray.removeAll()
     	       for plan in trips {
     	           self.tripArray.append(plan)
     	       }
     	       self.tableView.reloadData()
     	       self.myRefreshControl.endRefreshing()
            
  	      } failure: { (Error) in
   	         print("Could not retrieve trips!")
   	         print(Error)
  	      }
        ```
      - (Update/PUT) Update user profile image and background
   - Settings Screen
      - (Update/PUT) Update any accessibility needs 
   - Logout
      ```swift
         let query = PFQuery(classname: “Logout”)  
         TwitterAPICaller.client?.logout()
  	     self.dismiss(animated: true, completion: nil)
     	 UserDefaults.standard.set(false, forKey: "userLoggedIn")
      ```
   - Create Screen
      - (Create/POST) Create a new plan object
      ```swift
        let query = PFQuery(classname: “Create Trip”)  
        @IBAction func Trip(_ sender: Any) {
  	      if (!Empty) {
            TwitterAPICaller.client?.createTrip(TripName String:TripTextView.text, TripDescription String: TripDescripionTextView.text, TripDestination String: TripDestinationTextView.text, TripDate String: TripDateTextView.text,  success: {
          	      self.dismiss(animated: true, completion: nil)
          	  }, failure: { (error) in

            	    print("Error creating trip \(error)")
            	    self.dismiss(animated: true, completion: nil)
          	  })
      	  } else {
      	      self.dismiss(animated: true, completion: nil)
      	  }
      ```
