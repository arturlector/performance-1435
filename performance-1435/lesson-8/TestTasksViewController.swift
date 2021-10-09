//
//  TestTasksViewController.swift
//  performance-1435
//
//  Created by Artur Igberdin on 08.10.2021.
//

import UIKit


protocol MyProtocol {
    //func sayHello()
}

//дефолтная реализация = обязаны сделать если протокол пустой
extension MyProtocol {
    func sayHello() {
        print("Hello protocol!")
    }
}

class MyClass: MyProtocol {
    func sayHello() {
        print("Hello class!")
    }
}

//////////////////

protocol Printable: AnyObject {
    func print()
}
extension Printable {
    func print() {
        Swift.print("Protocol")
    }
}

class TestTasksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        class A: Printable { } // protocol
        class B: A
        {
            func print() {
                Swift.print("I'm B")
                
            }
        }
        class C: Printable {
            func print() {
                Swift.print("I'm C")
                
            }
        }
        
        let array: [Printable] = [A(), B(), C()]
        array.forEach { $0.print() } // protocol, B


//        let instance1 = MyClass()
//        let instance2: MyProtocol = MyClass()
//
//        instance1.sayHello() //witness-table dispatch (dynamic)
//        instance2.sayHello() //direct dispatch (static)
        
        
        
        //testTask10()
        
        // main-поток -> автоматически активируется RunLoop -> задачи поставленные по таймеру
        // другой-поток -> чтобы RunLoop работал нужно его запустить
//        DispatchQueue.global().async {
//            self.perform(#selector(self.sayHello), with: nil, afterDelay: 0.5)
//            RunLoop.current.run()
//        }
    }
    
    @objc
       func sayHello() {
           print("Hello")
       }
    
    func testTask0() {
        
        
        let a: Double = 1.000001
        let b: Double = 0.000001
        let c = a - b
        
        print(c)
        
        let a1: Decimal = 1.000001
        let b1: Decimal = 0.000001
        let c1 = a1 - b1
        
        print(c1)
    }
    
    func testTask1() {

        let val: Double = 1.0
        let a: Double = 1.000001
        let b: Double = 0.000001
        let c = a - b

//        let a1: Decimal = 1.000001
//        let b1: Decimal = 0.000001
//        let c1 = a1 - b1

        let arr: [Double] = [2.0, 3.0, 1, 4.0, 8.99, 1.00 * 1, a - b]

        var countOfVal: Int = 0

        for i in 0..<arr.count {

            if arr[i] == val {
                countOfVal = countOfVal + 1
            }
        }

        print(countOfVal)
    }
    
    func testTask2() {
        
        //Именованная очередь - пользовательская очередь - 5 поток - serial
        let queue = DispatchQueue(label: "com.customqueue")

        queue.async {
            //5 поток - захватывает 1 и 2
            
            print(Thread.isMainThread)
            print(Thread.current)
            
            print("1")
            
            // стопанет 5 поток - внутри 5 поток не может выполниться
            queue.sync {
                //5 поток - захватывает 2

                //взаимная блокировка
                print("2")
            }
            
            //стопанет 5 поток - 1 поток не на стопе он может выполниться
            DispatchQueue.main.sync {
                //1 поток - захватывает 2
                
                print("2")
            }
        }
    }
    
    func testTask3() {
        
        // последовательная очередь = 1 поток
        // глобальная очередь = конкуретная = много потоков
        DispatchQueue.global().async {
            print("1")
            
            print(Thread.current)
            
            DispatchQueue.global().sync {
                
                print(Thread.current)
                
                print("2")
                DispatchQueue.global().sync {
                    
                    print(Thread.current)
                    print("3")
                }
                print("4")
            }
            print("5")
        }
        print("6")
        
    }
    
    func testTask4() {
       
        DispatchQueue.main.async {
            debugPrint("A")
            DispatchQueue.main.sync {
                debugPrint("B")
            }
            debugPrint("C")
        }
        debugPrint("D")
        
    }
    
    func testTask5() {
        
        func viewDidLoad() {
            print(2)

            DispatchQueue.global().async {
                print(3)
                DispatchQueue.main.sync {
                    print(4)
                }
                print(5)
            }
            print(6)
        }

        print(1)
        viewDidLoad()
        print(7)
        
    }
    
    func testTask6() {
        
        //copy-on-write - для коллекций (array, dict, set)
        
        var foo = [420]
        var bar = foo //bar смотрит на область памяти foo
        foo[0] = 228 //copy on write
        debugPrint(bar[0])
    }
    
    func testTask7() {
        
        //Copy-On-Write
        
        struct Tutorial {
            var difficulty: Int = 1
        }
        
        //ex 1
        var tutorial1 = Tutorial() // 1
        var tutorial2 = tutorial1 // 1
        tutorial2.difficulty = 2 //2
                 
        //ex 2
        var array1 = [1, 2, 3, 4, 5] // 12345
        var array2 = array1 //12345
        array2.append(6) //123456
        var len = array1.count //5
        
    }
    
    func testTask8() {
        
        struct Planet {
            var name: String
            var distanceFromSun: Double
        }
                 
        let planets = [
            Planet(name: "Mercury", distanceFromSun: 0.387),
            Planet(name: "Venus", distanceFromSun: 0.722),
            Planet(name: "Earth", distanceFromSun: 1.0),
            Planet(name: "Mars", distanceFromSun: 1.52),
            Planet(name: "Jupiter", distanceFromSun: 5.20),
            Planet(name: "Saturn", distanceFromSun: 9.58),
            Planet(name: "Uranus", distanceFromSun: 19.2),
            Planet(name: "Neptune", distanceFromSun: 30.1)
        ]
                 
        let result1 = planets.map { $0.name }
        let result2 = planets.reduce(0) {$0 + $1.distanceFromSun }
        
        print(result1) //все неймы
        print(result2) // результирующее число
    }
    
    func testTask9() {
        
        //didSet
        
        final class Container {
            var array: [Int] = [] {
                didSet {
                    print("DidSet:\(array)")
                }
            }
            
            init(array: [Int]) {
                print("init")
                self.array = array //при инициализации не срабатывает didSet
            }
            
            deinit {
                print("deinit")
                array = [4]
            }
            
            func update() {
                array.append(3)
            }
        }

        var container: Container? = Container(array: [1]) //
        container?.array = [2] // DidSet 2
        container?.update() // DidSet 2,3
        container = nil // deinit
        
    }
    
    func testTask10() {
        
        class Master {
            //главный объект
            lazy var detail: Detail? = Detail(master: self)
          
            init() {
                print("Master init")
            }
            
            deinit {
                print("Master deinit")
            }
        }
        
        class Detail {
            
            weak var master: Master?
            
            init(master: Master) {
                print("Detail init")
                self.master = master
            }
            
            deinit {
                print("Detail deinit")
            }
        }
        
        func createMaster() {
            
            
            
            
            var master: Master? = Master()
            var detail = master?.detail
            
            //master = nil
            
            print(master)
            print(detail)
        }
        
        createMaster()
        
    }
    
    func testTask11() {
        
    
        
    }
    
    func testTask12() {
        
    }
    
    func testTask13() {
        
    }
    
    func testTask14() {
        
    }
    
    func testTask15() {
        
    }
    
    func testTask16() {
        
    }
    
    func testTask17() {
        
    }
    
    func testTask18() {
        
    }
    
    func testTask19() {
        
    }
    
    func testTask20() {
        
    }
    

  

}
