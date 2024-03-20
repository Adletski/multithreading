//
//  ViewController.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 19.03.2024.
//

import UIKit

class TaskOne: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        // TASK 1-1
        /* У нас обычно включен главный поток, получается если мы запускаем
         задачи на главном потоке, у нас главный поток последовательный, сначала сработают
         все с выводом 1, а потом с выводом 2 ) работают на главном потоке последовательном )
         */
//        for _ in (0..<10) {
//            let currentThread = Thread.current
//            print("1, Current thread: \(currentThread)")
//        }
//
//        for _ in (0..<10) {
//            let currentThread = Thread.current
//            print("2, Current thread: \(currentThread)")
//        }
        
        /*
         Если мы хотим чтобы вывод 2 не ждал окончания 1 вывода, надо создать новый поток и запустить на нем вывод 1, а вывод 2 оставить на главном потоке )
         */
        
//        for _ in (0..<100) {
//            let currentThread = Thread.current
//            print("1, Current thread: \(currentThread)")
//        }
//        
//        
//        Thread.detachNewThread {
//            for _ in (0..<100) {
//                let currentThread = Thread.current
//                print("2, Current thread: \(currentThread)")
//            }
//        }
        // TASK 1-1
        
        // TASK 1-2
        let timer = TimerThread(duration: 10)
        timer.start()
        // TASK 1-2
    }
}

// TASK 1-2
class TimerThread: Thread {
    private var timerDuration: Int
    private var timer: Timer!
    
    init(duration: Int) {
        self.timerDuration = duration
    }
    
    override func main() {
        // Создаем таймер, который будет выполняться каждую секунду
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        print(Thread.current)
        
        // Добавляем таймер в текущий run loop ниже
        let runloop = RunLoop.current
        runloop.add(timer, forMode: .default)
        
        // Запускаем текущий run loop ниже
        runloop.run()
    }
    
    @objc func updateTimer() {
        // Ваш код здесь будет выполняться каждую секунду
        if timerDuration > 0 {
            print("Осталось \(timerDuration) секунд...")
            timerDuration -= 1
        } else {
            print("Время истекло!")
            
            timer.invalidate()
            // Остановка текущего run loop после завершения таймера
            CFRunLoopStop(CFRunLoopGetCurrent())
        }
    }
}
// TASK 1-2
