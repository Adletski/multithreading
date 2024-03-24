//
//  TaskThreeThree.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 21.03.2024.
//

import UIKit

class TaskThreeThree: UIViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            var people1 = People1()
            var people2 = People2()
            
            let thread1 = Thread {
                people1.walkPast(with: people2)
            }

            thread1.start()

            let thread2 = Thread {
                people2.walkPast(with: people1)
            }

            thread2.start()
        }
}

class People1 {
    var isDifferentDirections = false;
    
    func walkPast(with people: People2) {
        while (!people.isDifferentDirections) {
            print("People1 не может обойти People2")
            sleep(1)
        }
        
        print("People1 смог пройти прямо")
        isDifferentDirections = true
    }
}

class People2 {
    var isDifferentDirections = false;
    
    func walkPast(with people: People1) {
        while (!people.isDifferentDirections) {
            print("People2 не может обойти People1")
            sleep(1)
        }
        
        print("People2 смог пройти прямо")
        isDifferentDirections = true
    }
}

// problem 1 data race
/*
 let serialQueue = DispatchQueue(label: "com.example.myQueue")

  serialQueue.async {
     serialQueue.sync {
         print("This will never be printed.")
     }
  }
 */
// потому что у нас сериал очередь и должна работать последовательно, внутри синк нельзя использовать

// problem 2 deadlock
/*
 override func viewDidLoad() {
        super.viewDidLoad()
        
        var sharedResource = 0

        DispatchQueue.global(qos: .background).async {
            for _ in 1...100 {
                sharedResource += 1
            }
        }

        DispatchQueue.global(qos: .background).async {
            for _ in 1...100 {
                sharedResource += 1
            }
        }
 }
 
 override func viewDidLoad() {
     super.viewDidLoad()
     
     var sharedResource = 0 {
         didSet {
             print(sharedResource)
         }
     }
     let semaphore = DispatchSemaphore(value: 1)
     
     DispatchQueue.global(qos: .background).async {
         for _ in 1...100 {
             semaphore.wait()
             sharedResource += 1
             semaphore.signal()
         }
     }
     
     DispatchQueue.global(qos: .background).async {
         for _ in 1...100 {
             semaphore.wait()
             sharedResource += 1
             semaphore.signal()
         }
     }
 }
 */
// получается у нас идет запись в шередпеременную и получается нам нужно чтобы он правильно добавлял при обращении, как вариант добавить семафор и получается при добавлении закрывать после добавления открывать

// problem 3 livelock
/*
 let serialQueue = DispatchQueue(label: "com.example.myQueue")

  serialQueue.async {
     serialQueue.sync {
         print("This will never be printed.")
     }
  }
 */
// потому что у нас сериал очередь и должна работать последовательно, внутри синк нельзя использовать

