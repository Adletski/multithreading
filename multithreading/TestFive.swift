//
//  TestFive.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 19.03.2024.
//

import UIKit

class TestFive: UIViewController {

    private lazy var name = "Input name"
    private let lockQueue = DispatchQueue(label: "name.lock.queue")
    private let nslock = NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // Создаем и запускаем поток
        let infinityThread = InfinityLoop5()
        infinityThread.start()

        // Подождем некоторое время, а затем отменяем выполнение потока
        sleep(5)
        // Отменяем тут
        infinityThread.cancel()
    }
}

class InfinityLoop5: Thread {
    var counter = 0
    
    override func main() {
        while counter < 30 && !isCancelled {
            counter += 1
            print(counter)
            InfinityLoop.sleep(forTimeInterval: 1)
        }
    }
}
