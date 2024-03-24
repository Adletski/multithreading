//
//  TaskTwoSix.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 20.03.2024.
//

import UIKit

class TaskTwoSix: UIViewController {
    
    private lazy var name = "I love RM"
    var lock = NSLock()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateName()
    }
    
    func updateName() {
        DispatchQueue.global().async {
            self.lock.lock()
            print(self.name) // Считываем имя из global
            self.lock.unlock()
            print(Thread.current)
        }
        
        self.lock.lock()
        print(self.name) // Считываем имя из main
        self.lock.unlock()
    }
}
