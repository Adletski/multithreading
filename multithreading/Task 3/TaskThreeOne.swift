//
//  TaskThree.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 21.03.2024.
//

import UIKit

class TaskThree: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var phrasesService = PhrasesService()
        let semaphore = DispatchSemaphore(value: 1)
        
        for i in 0..<10 {
//            DispatchQueue.global().async {
            Task {
                await phrasesService.addPhrase("Phrase \(i)")
            }
//            }
        }
        // Даем потокам время на завершение работы
        Thread.sleep(forTimeInterval: 1)
        
        // Выводим результат
        Task {
            await print(phrasesService.phrases)
        }
    }
}

actor PhrasesService {
    var phrases: [String] = []
    let semaphore = DispatchSemaphore(value: 1)
    
    func addPhrase(_ phrase: String) {
        semaphore.wait()
        phrases.append(phrase)
        semaphore.signal()
    }
}
