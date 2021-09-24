//
//  Promise.swift
//  performance-1435
//
//  Created by Artur Igberdin on 24.09.2021.
//

import Foundation

/*
class Future<T> {
   // Будущее значение имеет три состояния:
   //      - опциональный nil, когда результат еще неизвестен;
   //      - .success(T), успешно полученный результат;
   //      - .failure(Error), ошибка.
   fileprivate var result: Result<T, Error>? {
       // Когда значение будет получено, мы должны вызвать все накопленные callback
       didSet {
           guard let result = result else { return }
           callbacks.forEach { $0(result) }
       }
   }
    
   private var callbacks = [(Result<T, Error>) -> Void]()
  
   func add(callback: @escaping (Result<T, Error>) -> Void) {
       callbacks.append(callback)
      
       // Если результат уже доступен — вызываем callback сразу
       result.map(callback)
   }
}

class Promise<T>: Future<T> {
    
   init(value: T? = nil) {
       super.init()
      
       // Если результат уже доступен, то мы сразу можем положить его
       // в success case нашего Future
       result = value.map(Result.success)
   }
  
   // Функции для выполнения или нарушения обещания
   func fulfill(with value: T) {
       result = .success(value)
   }
  
   func reject(with error: Error) {
       result = .failure(error)
   }
}

extension Future {
    
   func map<NewType>(with closure: @escaping (T) throws -> NewType) -> Future<NewType> {
       
    let promise = Promise<NewType>()
       // Добавляем callback к существующему Future
       add(callback: { result in
           switch result {
           case .success(let value):
               do {
                   // Когда значение готово, применяем к нему
                   // модифицирующее замыкание и выполняем обещание
                   let mappedValue = try closure(value)
                   promise.fulfill(with: mappedValue)
               } catch {
                   promise.reject(with: error)
               }
           case .failure(let error):
               promise.reject(with: error)
           }
       })
       return promise
   }
}

extension Future {
   func flatMap<NewType>(with closure: @escaping (T) throws -> Future<NewType>) -> Future<NewType> {
      
       let promise = Promise<NewType>()
      
       // Добавляем callback к существующему Future
       add(callback: { result in
           switch result {
           case .success(let value):
               do {
                   // Когда значение первого Promise получено,
                   // на его основе генерируем новый Promise
                   let chainedPromise = try closure(value)
                   // и добавляем к нему новый callback
                   chainedPromise.add(callback: { result in
                       switch result {
                       case .success(let value):
                           promise.fulfill(with: value)
                       case .failure(let error):
                           promise.reject(with: error)
                       }
                   })
               } catch {
                   promise.reject(with: error)
               }
           case .failure(let error):
               promise.reject(with: error)
           }
       })
      
       return promise
   }
}
*/
