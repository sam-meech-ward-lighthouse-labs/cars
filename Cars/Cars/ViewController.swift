//
//  ViewController.swift
//  Cars
//
//  Created by Sam Meech-Ward on 2019-06-10.
//  Copyright © 2019 meech-ward. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    
  }


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
}

