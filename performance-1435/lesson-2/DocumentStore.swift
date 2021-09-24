//
//  DocumentStore.swift
//  performance-1436
//
//  Created by Artur Igberdin on 20.09.2021.
//

import Foundation

class DocumentStore: CustomStringConvertible {
    
    private var documents = [Document]()
    private let syncQueue = DispatchQueue(label: "DocumentStoreSyncQueue", attributes: .concurrent)
    
    // task 4
    func createDocument(fromName name: String) {
            syncQueue.async(flags: .barrier) {
                let lastId = self.documents.last?.id ?? 0
                let newId = lastId + 1
                let doc = Document(id: newId, name: name)
                self.documents.append(doc)
            }
    }
    
    func getDocument(byId id: Int) -> Document? {
        
        var document: Document?
        
        syncQueue.sync {
            if let index = self.documents.firstIndex(where: { $0.id == id }) {
                document = self.documents[index]
            }
        }
        return document
    }
    
    func getLastDocument() -> Document? {
        
       var document: Document?
       syncQueue.sync {
           document = self.documents.last
       }
       return document
   }
    
    func append(document: Document) {
        
        syncQueue.async(flags: .barrier) {
            self.documents.append(document)
        }
    }
    
    var description: String {
        
       var description = ""
       syncQueue.sync {
           description = self.documents.reduce("") { $0 + $1.description + ", " }
       }
       return description
    }
       
        
}
