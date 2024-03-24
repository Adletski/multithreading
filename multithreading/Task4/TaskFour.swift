//
//  TaskFour.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 22.03.2024.
//

import UIKit

class TaskFour: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("asdads")
    }
}

/* 1. Объясните в конспекте что такое Operation(Операция).
 Operation, который позволяет абстрагироваться от понятий потоков, блоков кода и очередей. С его помощью создаются операции, которые выполняются на отдельных потоках. Их можно выстроить в цепочки с определённой последовательностью.
 Например, можно определить такую очередность выполнения операций: получаем данные из интернета — сохраняем их в базу — извлекаем из базы — обновляем таблицу.
 
 2. Так же объяснить что такое OperationQueue(Очередь операций).
 Все операции выполняются на очередях. Они представлены классом OperationQueue. Но это не те
 очереди, которые вы видели на уроке про GCD. Они и проще, и сложнее одновременно.
 Есть только одна готовая очередь по умолчанию — OperationQueue.main, связанная с главным потоком. Дополнительные очереди вы создаёте по мере необходимости. Обойтись можно всего двумя — главной и одной дополнительной. У OperationQueue доступен всего один конструктор, не принимающий никаких параметров.
 
 3.В чем отличие отмены  DispatchQueueWorkItem и отменой Operation.
 DispatchQueueWorkItem нельзя отменить если уже началась работа, в свою очередь в оперейшн можно отмениить и в момент работы.
 
 4. Для чего нужна Operation Dependency
 When working with multiple instances of Operation, you’ll often want to queue up work that needs to be performed sequentially rather than all at once. If you want one operation to wait for another to complete before it starts, regardless of which operation queue either one is running on, you should use addDependency() to make the sequence clear to the system.
 As an example, we could create two instances of BlockOperation that each print messages and pause a little:
 let operation1 = BlockOperation {
     print("Operation 1 is starting")
     Thread.sleep(forTimeInterval: 1)
     print("Operation 1 is finishing")
 }

 let operation2 = BlockOperation {
     print("Operation 2 is starting")
     Thread.sleep(forTimeInterval: 1)
     print("Operation 2 is finishing")
 }
 If we added those directly to an operation queue, they would both start running immediately. However, we could tell operation2 that it needs to wait for operation1 to complete, like this:
 operation2.addDependency(operation1)
 Now if we add the operations to a queue they will execute sequentially rather than in parallel:
 print("Adding operations")
 let queue = OperationQueue()
 queue.addOperation(operation1)
 queue.addOperation(operation2)
 queue.waitUntilAllOperationsAreFinished()
 print("Done!")
 You can add dependencies across operation queues if you need, which means you can queue up work to run in the background, then the main thread, then back to the background again without causing problems. So, we could rewrite the above code to run the operations on separate operation queues and we’d still get the same end result:
 print("Adding operations")
 let queue1 = OperationQueue()
 let queue2 = OperationQueue()
 queue1.addOperation(operation1)
 queue2.addOperation(operation2)
 queue2.waitUntilAllOperationsAreFinished()
 print("Done!")
 5.Объяснить для чего в swift 5.5 появился новый протокол Sendable и атрибут @Sendable и что они делают
 помечают что класс подтвержден конкурентной защите и безопасен
 // Sendable thread safety problems, 2 threads editing data
 // Ensures concurrent safety

 final class Person: Sendable {
     let value: Int
     
     init(value: Int) {
         self.value = value
     }
 }
 6. Объяснить почему run loop отправляет поток в сон (thread.sleep) и в какой ситуации он это делает?
 
 По большому счету, Run Loop — это то, что отличает интерактивное мобильное приложение от обычной программы. Когда Run Loop получает сообщение о событии, он запускает обработчик, ассоциированный с этим событием на своем потоке, а после выполнения усыпляет поток до следующего события, именно таким образом приложение узнает о происходящих интерактивных событиях
 
 7. Объяснить зачем нужны такие события как Timers Sources и Input Sources для RunLoop и что они делают?
 Существует несколько источников события:
 Input sources — различные источники ввода (мышь, клавиатура, тачскрин и тп), кастомные источники (необходимы для передачи сообщений между потоками), а так же вызов performSelector:onThread: (метод, необходимый для вызова события по селектору на определенном потоке)
 Timer sources — все таймеры в приложении всегда обрабатываются ранлупом
 
8.
 class ViewController: UIViewController {

 final class Post: Sendable {
         
 }

 enum State1: Sendable {
      case loading
      case data(String)
 }
     
 enum State2: Sendable {
      case loading
      case data(Post) // Out: Associated value 'data' of 'Sendable'-conforming enum 'State2' has non-sendable type 'ViewController.Post'
 }

 }
 9. 
 
*/

class GetDataOperation: Operation {
    
    enum State: String {
    case ready, executing, finished
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    private var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .ready
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    
    override func cancel() {
        
    }
}

