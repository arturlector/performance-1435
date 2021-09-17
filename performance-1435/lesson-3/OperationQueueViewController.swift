//
//  OperationQueueViewController.swift
//  performance-1435
//
//  Created by Artur Igberdin on 17.09.2021.
//

import UIKit

class OperationQueueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        //fromBackroundQueueToMain()
        
        //concurrentOperationsInOperationQueue()
        
        dependencyOperations()
    }
    
    func dependencyOperations() {
        
        let queue = OperationQueue()
        
        let operation1 = BlockOperation() {
            for i in 0..<10 {
                print("🤠\(i)")
                self.printThread()
            }
        }
        
        let operation2 = BlockOperation() {
            for i in 0..<10 {
                print("🤡\(i)")
                self.printThread()
            }
        }
        
        let operation3 = BlockOperation() {
            for i in 0..<10 {
                print("🤖\(i)")
                self.printThread()
            }
        }
        
        let finalOperation = BlockOperation() {
            print("All operations completed!")
            
            for i in 0..<10 {
                print("🎃\(i)")
                self.printThread()
            }
            
            self.printThread()
        }
        
//        finalOperation.addDependency(operation1)
//        finalOperation.addDependency(operation2)
//        finalOperation.addDependency(operation3)
        
        operation2.addDependency(operation1)
        operation3.addDependency(operation2)
        finalOperation.addDependency(operation3)
        
        let operations = [
            finalOperation,
            operation1,
            operation2,
            operation3
        ]
        
        queue.addOperations(operations, waitUntilFinished: false)
        
    }
    
    func concurrentOperationsInOperationQueue() {
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1 //сделали последовательной
        
        queue.addOperation {
            for i in 0..<10 {
                print("🤠\(i)")
                self.printThread()
            }
            
        }
        
        queue.addOperation {
            for i in 0..<10 {
                print("🤡\(i)")
                self.printThread()
            }
            
        }
        
        queue.addOperation {
            for i in 0..<10 {
                print("🤖\(i)")
                self.printThread()
            }
            
        }
        
        
    }
    
    func fromBackroundQueueToMain() {
        
        let queue = OperationQueue()
        
        queue.addOperation {
            print("1")
            
            self.printThread()
            
            OperationQueue.main.addOperation {
                print("This is main thread")
                self.printThread()
            }
            
        }
    }
    
    func printThread() {
        print("Is main Thread: \(Thread.isMainThread)")
        print(Thread.current)
    }

   

}
