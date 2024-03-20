//
//  TaskTwoFive.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 20.03.2024.
//

import UIKit

class TaskTwoFive: UIViewController {
     override func viewDidLoad() {
              super.viewDidLoad()
              print(2)
              DispatchQueue.main.async {
                      print(3)
                      DispatchQueue.main.sync {
                            print(5)
                      }
               print(4)
             }
           print(6)
     }
}

//let vc = ViewController()
//print(1)
//let view = vc.view
//print(7)

// выведется до 5 ( 1 2 6 7 3 )

