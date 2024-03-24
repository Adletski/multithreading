//
//  TaskFour.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 19.03.2024.
//

import UIKit

class TaskFour2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Создаем и запускаем поток
        let thread1 = ThreadprintDemon()
        let thread2 = ThreadprintAngel()
        
        // Меняем приоритеты
        // 1. print 1 and after 2
        thread1.qualityOfService = .userInteractive
        thread2.qualityOfService = .background
        // 2. print 2 and after 1
        thread1.qualityOfService = .background
        thread2.qualityOfService = .userInteractive
        // 3. shufle printing
        thread1.qualityOfService = .userInteractive
        thread2.qualityOfService = .userInteractive
        
        thread1.start()
        thread2.start()
    }
}

class ThreadprintDemon: Thread {
    override func main() {
        for _ in (0..<100) {
            print("1")
        }
    }
}
class ThreadprintAngel: Thread {
    override func main() {
        for _ in (0..<100) {
            print("2")
        }
    }
}
