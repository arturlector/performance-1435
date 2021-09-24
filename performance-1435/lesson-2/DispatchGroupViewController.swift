//
//  GCDViewController.swift
//  performance-1436
//
//  Created by Artur Igberdin on 20.09.2021.
//

import UIKit

struct Document: CustomStringConvertible {
    let id: Int
    let name: String
    
    var description: String {
        return "\(id) - \(name)"
    }
}

class DispatchGroupViewController: UIViewController {

    var documents: [Document] = []
    
    let documentStore = DocumentStore()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
       
        
        
        //test1()
        
        //test2()
        
        //test3()
        
        //test4()
        
        test5()
    }
    
    func test5() {
        
        DispatchQueue.global().sync {
            print("😈")
        }
                
        print("😇")
    }
    
    
    
    func test4() {
        
        let firstChar = UnicodeScalar("А").value
        let lastChar = UnicodeScalar("Я").value
        let dispatchGroup = DispatchGroup()
               
        for charCode in firstChar...lastChar {
            DispatchQueue.global().async(group: dispatchGroup) {
                let docName = String(UnicodeScalar(charCode)!)
                self.documentStore.createDocument(fromName: docName)
            }
        }
                
        dispatchGroup.notify(queue: DispatchQueue.main) {
             print(self.documentStore)
        }
        
    }
    
    func test3() {
        
        let firstChar = UnicodeScalar("А").value
        let lastChar = UnicodeScalar("Я").value
        let dispatchGroup = DispatchGroup()
               
        for charCode in firstChar...lastChar {
            
            DispatchQueue.global().async(group: dispatchGroup) {
                let docName = String(UnicodeScalar(charCode)!)
                let lastId = self.documentStore.getLastDocument()?.id ?? 0
                let newId = lastId + 1
                let doc = Document(id: newId, name: docName)
                self.documentStore.append(document: doc)
            }
            
         }
                
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print(self.documentStore)
        }
    }
    
    func test2() {
        
        let dispatchGroup = DispatchGroup()
        

        let firstChar = UnicodeScalar("А").value//1040
        let lastChar = UnicodeScalar("Я").value//1071
        
        for charCode in firstChar...lastChar {
            
            
            DispatchQueue.global().async(group: dispatchGroup) {
                let docName = String(UnicodeScalar(charCode)!)
                
                let lastId = self.documents.last?.id ?? 0
                let newId = lastId + 1
                
                let doc = Document(id: newId, name: docName)
                self.documents.append(doc) //ошибка - массив не потокобезовасная структура данных
            }
            
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [self] in
            print(documents)
        }
    }
    
    
    
    func test1() {
        
        var documents: [Document] = []
        
        let char = UnicodeScalar("A")
        let char1 = Character("A").asciiValue
        
        let firstChar = UnicodeScalar("А").value//1040
        let lastChar = UnicodeScalar("Я").value//1071
        
        for charCode in firstChar...lastChar {
            
            let docName = String(UnicodeScalar(charCode)!)
            
            let lastId = documents.last?.id ?? 0
            let newId = lastId + 1
            
            let doc = Document(id: newId, name: docName)
            documents.append(doc)
        }
        print(documents)
       
    }
    
}
