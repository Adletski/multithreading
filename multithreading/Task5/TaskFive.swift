//
//  TaskFive.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 24.03.2024.
//

import UIKit

class TaskFive: UIViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        Task {
            await printMessage()
        }
    }
    
    func printMessage() async {
        let string = await withTaskGroup(of: String.self) { group -> String in
           // тут добавляем строки в группу
            group.addTask { "hello" }
            group.addTask { "my" }
            group.addTask { "road" }
            group.addTask { "map" }
            group.addTask { "group" }

            var collected = [String]()

            for await value in group {
                collected.append(value)
            }

            return collected.joined(separator: " ")
        }

        print(string)
    }
}

/*
 1.Обьяснить такое понятие как Swift Concurrency которое появилось в Swift 5.5?
 это инструмент для отслеживания работы с мнопоточностью
 2. Объяснить что такое Task и зачем он нужен. И какой аналог есть в CGD?
 Task по сути это тот же DispatchQueue.main.async который просто создает асинхронное выполнение, а внутри кложуры передаем какое то исполнение метода
 3. 
 class ViewController: UIViewController {
 
 override func viewDidLoad() {
         super.viewDidLoad()
     
     print(1)
     DispatchQueue.main.async {
         print(2)
     }
     print(3)
 }
}
 распечается 1 3 2, так как очередь последовательная и задачу поставили последовательно в очередь
 если изменить на Таск ничего не поменяется
 4.
 class ViewController: UIViewController {
     
     override func viewDidLoad() {
             super.viewDidLoad()
         
         print(1)
         Task { @MainActor  in
             print(2)
         }
         print(3)
     }
 }
 это обозначает запуск на мейн очереди
 5.
 class ViewController: UIViewController {
     

     override func viewDidLoad() {
             super.viewDidLoad()
         
         print("Task 1 is finished")
        
         Task.detached {
             for i in 0..<50 {
                 print(i)
             }
             print("Task 2 is finished")
             print(Thread.current)
         }
         
         print("Task 3 is finished")
     }
 }
 Task.detached по сути переходит из действующего конкарент очереди в другой, приоритет как обычно показывает важность выполнения
 6.
 override func viewDidLoad() {
     super.viewDidLoad()
     
     
     func randomD6() async -> Int {
         Int.random(in: 1...6)
     }
     
     Task {
         let result =  await randomD6()
         print(result)
     }
 }
 7.
 class TaskFive: UIViewController {
     
    
     var networkService = NetworkService()
     
     override func viewDidLoad() {
             super.viewDidLoad()
         
         Task {
             let result = await fetchMessages()
             print(result)
         }
     }
     
     func fetchMessages() async -> [Message] {
         await withCheckedContinuation { continuation in
             networkService.fetchMessages { messages in
                 continuation.resume(returning: messages)
             }
         }
     }
 }

 struct Message: Decodable, Identifiable {
     let id: Int
     let from: String
     let message: String
 }


 class NetworkService {
     
     func fetchMessages(completion: @escaping ([Message]) -> Void) {
         let url = URL(string: "https://hws.dev/user-messages.json")!

         URLSession.shared.dataTask(with: url) { data, response, error in
             if let data = data {
                 if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                     completion(messages)
                     return
                 }
             }

             completion([])
         }
         .resume()
     }
 }
 8.
 enum FetchError: Error {
 case noMessages
 }

 class TaskFive: UIViewController {
     
     var networkService = NetworkService()
     
     override func viewDidLoad() {
             super.viewDidLoad()
         
         Task {
             let result = await fetchMessages()
             print(result)
         }
     }
     
     func fetchMessages() async -> [Message] {
         do {
             return try await withCheckedThrowingContinuation { continuation in
                 networkService.fetchMessages { messages in
                     if messages.isEmpty {
                         continuation.resume(throwing: FetchError.noMessages)
                     } else {
                         continuation.resume(returning: messages)
                     }
                 }
             }
         } catch {
             return [Message(id: 1, from: "adlet", message: "welcome")]
         }
     }
 }

 struct Message: Decodable, Identifiable {
     let id: Int
     let from: String
     let message: String
 }


 class NetworkService {
     
     func fetchMessages(completion: @escaping ([Message]) -> Void) {
         let url = URL(string: "https://hws.dev/user-messages.json")!

         URLSession.shared.dataTask(with: url) { data, response, error in
             if let data = data {
                 if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                     completion(messages)
                     return
                 }
             }

             completion([])
         }
         .resume()
     }
 }
 9.
 class TaskFive: UIViewController {
     
     override func viewDidLoad() {
             super.viewDidLoad()
         
         Task {
             await getAverageTemperature()
         }
     }
     
     func getAverageTemperature() async {
         let fetchTask = Task { () -> Double in
             let url = URL(string: "https://hws.dev/readings.json")!
             let (data, _) = try await URLSession.shared.data(from: url)
             let readings = try JSONDecoder().decode([Double].self, from: data)
             let sum = readings.reduce(0, +)
             return sum / Double(readings.count)
         }
         
        // Тут отмените задачу
         fetchTask.cancel()

         do {
             let result = try await fetchTask.value
             print("Average temperature: \(result)")
         } catch {
             print("Failed to get data.")
         }
     }
 }
 10.
 class TaskFive: UIViewController {
     
     override func viewDidLoad() {
             super.viewDidLoad()
         
         Task {
             await printMessage()
         }
     }
     
     func printMessage() async {
         let string = await withTaskGroup(of: String.self) { group -> String in
            // тут добавляем строки в группу
             group.addTask { "hello" }
             group.addTask { "my" }
             group.addTask { "road" }
             group.addTask { "map" }
             group.addTask { "group" }

             var collected = [String]()

             for await value in group {
                 collected.append(value)
             }

             return collected.joined(separator: " ")
         }

         print(string)
     }
 }
 */
