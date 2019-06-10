## Servers + Push Notifications

* Backend dev would create endpoints that an iOS dev could access. 
* iOS dev can use those endpoints to `GET` and `POST` and update and `DELETE` data.
* A bunch of responses can come back
  - 400
  - 401
  - 100
  - 200 OK 
  - 300
  - 404 Not Found
  - 418 I'm a teapot
  - 420 Enhance your calm
  - 500
* They can be secure `s` or not secure ``. 
* Access the same data across many different devices (clients)
* 

## HTTP

* Something Something Something Protocol (SSSP)
* HyperText Transfer Protocol.
  - Text with hyperlinks.
* 1.1 is Text based protocol.
* We can send anything that can be represented as text.
* JSON & dictionaries.

```
JSON:
"cat": {
  "name": "mittens",
  "lives": 9
}

XML:
<cat>
  <name>mittens</name>
  <lives>9</lives>
</cat>
```

### Request

1. HTTP method (verb) `GET`, `POST`, `DELETE`, `PUT`, `HEAD`, `PATCH`
  - should describe what we want to do. 
2. endpoint, the path `/cats`, `/meals` (https://www.somesize.com/cats)

These two pieces of information make a **route**.

### Response

1. Status codes
  - 1xx informational
  - 2xx OK
  - 3xx Redirect
  - 4xx Client Error (client fucked up) 
    - our iphone app made a mistake
  - 5xx Server Error (server fucked up)
    - the server made a mistake
2. Data (body)  
  - json, html, xml


## Stateless

* No State
* The server does not keep track of the clients.
* Every new request must contain all data needed to identify the client.

## REST

* REpresentational State Transfer
* RESTful

* Use paths and methods (routes) in a specific way to create, read, update, delete data.

www.yoursite.com

`/collection` (`/cats`)

* Create a new cat `POST www.yoursite.com/cats`
* get every single cat `GET www.yoursite.com/cats`

* Use the methods to specify what to do `GET`, `POST`, `DELETE`, `PUT`
* use the path the specify the resource

`/collection/id/`

* GET a single cat `/cats/1/`

`/collection/id/subcollection`

* GET `/cats/1/meals`
* GET `/meals`

* `GET` get some data, it's a safe method. It won't update the resource.
* `POST` create new data, it's unsafe.
* `DELETE` delete some data, it's idempotent. 1 === 1000
* `PUT` replace data (update), it's idempotent.

## Notifications

* when should you present a notification to a user? 
  - only when necessary. 
  - when it adds value to the user experience.

* When should you ask if it's ok to send notifications? (permission)
  - when the user is most likely is to say yes.

### Local

* don't need a server
  - triggers
    - date to define a date when a notification will be presented to the user.
    - timeInterval to define a time from now that a notification will be presented.
    - location to notify you when you enter or leave a location.

### Push

* comes from a server

### Silent

* a notification that the user doesn't see.

## Snippets

### Notifications

```swift
@IBAction func notifyMe(_ sender: Any) {
    let center = UNUserNotificationCenter.current()
    // Request permission to display alerts and play sounds.
    center.requestAuthorization(options: [.alert, .sound, .badge])
    { (granted, error) in
      // Enable or disable features based on authorization.
      print("granted \(granted)")
      
      
      let content = UNMutableNotificationContent()
      content.title = "Nice Tesla Bro"
      content.body = "Your car has been summoned."
      
//      // Configure the recurring date.
//      var dateComponents = DateComponents()
//      dateComponents.calendar = Calendar.current
//
//      dateComponents.weekday = 2  // Tuesday
//      dateComponents.hour = 15    // 14:00 hours
//      dateComponents.minute = 55
//
//      // Create the trigger as a repeating event.
//      let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
      
      // Create the request
      let uuidString = UUID().uuidString
      let request = UNNotificationRequest(identifier: uuidString,
                                          content: content, trigger: trigger)
      

      center.add(request) { (error) in
        if error != nil {
          // Handle any errors.
          print("error adding")
        }
      }
      
    }
  }
```

### HTTP

```swift
struct Cat: codeable {
  var name: String
  var lives: Int
} 
func save(thing: Thing) throws {
  let url = URL(string: "http://localhost:4000/cats")!
  let request = NSMutableURLRequest(url: url)
  request.httpBody = try JSONEncoder().encode(cat)
  request.httpMethod = "POST"
  request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  
  let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
    if let error = error {
      print(error)
      return
    }
    
    guard let data = data else {
      return
    }
    
    print(data)
  }
  
  dataTask.resume()
}
```