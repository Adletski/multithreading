//
//  TaskTwo.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 19.03.2024.
//

import UIKit

class TaskTwo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown

        // Создаем и запускаем поток
        let infinityThread = InfinityLoop()
        infinityThread.start()

        // Подождем некоторое время, а затем отменяем выполнение потока
        sleep(5)
        // Отменяем тут
        infinityThread.cancel()
    }
}

class InfinityLoop: Thread {
    var counter = 0
    
    override func main() {
        while counter < 30 && !isCancelled {
            counter += 1
            print(counter)
            InfinityLoop.sleep(forTimeInterval: 1)
        }
    }
}
