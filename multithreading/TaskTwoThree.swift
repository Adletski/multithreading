//
//  TaskTwoThree.swift
//  multithreading
//
//  Created by Adlet Zhantassov on 20.03.2024.
//

import UIKit

class TaskTwoThree: UIViewController {
    
    private var name = "Введите имя"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateName()
    }
    
    func updateName() {
        DispatchQueue.global().async {
            self.name = "I love RM" // Перезаписываем имя в другом потоке
            print(Thread.current)
            print(self.name)
        }
        
        print(self.name) // Считываем имя из main
    }
}
// если async то выполнится кто быстрее сможет
// если sync то выполнится сначала глобал
// проблема в том, что так как у нас global.async то непонятно когда он выполнится и получается может произойти момент когда меняем имя и считываем одновременно c прайвет lockQueue мы можем эти действия положить в одну очередь и там изменять и смотреть

/*class TaskTwoThree: UIViewController {
 
 private var name = "Введите имя"
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 updateName()
 }
 
 func updateName() {
 DispatchQueue.global().async {
 self.name = "I love RM" // Перезаписываем имя в другом потоке
 print(Thread.current)
 print(self.name)
 }
 
 print(self.name) // Считываем имя из main
 }
 }
 */
