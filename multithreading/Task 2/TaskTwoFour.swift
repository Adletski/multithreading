//
//  TaskTwoFour.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 20.03.2024.
//

import UIKit

class TaskTwoFour: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("A")
        
        DispatchQueue.main.async {
            print("B")
        }
        
        print("C")
    }
}

// последовательная очередь и изза этого добавляется в конец, сначала выполняется основная очередь которая идет
