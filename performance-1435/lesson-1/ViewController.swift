//
//  ViewController.swift
//  performance-1435
//
//  Created by Artur Igberdin on 10.09.2021.
//

import UIKit

class ThreadprintDemon: Thread {
    override func main() {
        for _ in (0..<100) {
            print("😈")
            Thread.sleep(forTimeInterval: 1)
        }
    }
}

class ThreadprintAngel: Thread {
    override func main() {
        for _ in (0..<100) {
            print("😇")
            Thread.sleep(forTimeInterval: 1)
        }
    }
}

class TimeThread: Thread {
    override func main() {
        // Настраиваем таймер
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
            print("Tick")
        }
        // Запускаем петлю
        RunLoop.current.run()
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(RunLoop.current)
        
        //runLoopWithGlobalAutorelase()
        
        //runLoopWithCustomAutoreleasePool()
        
        //asyncTaskByTimer()
        
        //singleThreadCode() //serial - последовательный
        
        //multiThreadCode()
        
        //multiThreadCodeUniversal()
        
        //twoThreadsWithQoS()
        timerThread()
    }
    
    func timerThread() {
        
        let timerThread = TimeThread()
        timerThread.start()
    }
    
    func twoThreadsWithQoS() {
        
        let thread1 = ThreadprintDemon()
        let thread2 = ThreadprintAngel()
                
        thread1.qualityOfService = .utility
        thread2.qualityOfService = .userInteractive
                
        thread1.start()
        thread2.start()

    }
    
    func multiThreadCodeUniversal() {
        
        let thread1 = Thread {
            for _ in (0..<1000) {
            print("😈")
            }
        }
                
        thread1.start()
        //thread1.cancel()
                
        for _ in (0..<1000) {
            print("😇")
        }
    }
    
    func multiThreadCode() {
        
        Thread.detachNewThread {
            for _ in (0..<1000) {
            print("😈")
            }
        }
                
        for _ in (0..<1000) {
            print("😇")
        }
    }
    
    func singleThreadCode() {
       
        for _ in (0..<10) {
          print("😈")
        }
                
        for _ in (0..<10) {
            print("😇")
        }
    }
    
    func asyncTaskByTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
            print(Date())
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            sleep(1)
        }
    }
    
    func runLoopWithCustomAutoreleasePool() {
       
        print("start test")
       
            for index in 0...UInt.max {
                autoreleasepool {
                    let string = NSString(format: "test + %d", index)
                    print(string)
                }
            }
      
        print("end test")
    }
    

    func runLoopWithGlobalAutorelase() {
        
        print("start test")
        
        print(UInt.max)
        for index in 0...UInt.max {
            let string = NSString(format: "test + %d", index)
            print(string)
        }
        print("end test")
    }
}

