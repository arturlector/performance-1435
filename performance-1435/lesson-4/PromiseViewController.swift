//
//  PromiseViewController.swift
//  performance-1435
//
//  Created by Artur Igberdin on 24.09.2021.
//

import UIKit

/*
class Weather: Decodable {
    
}


class PromiseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        let promise = fetchWeatherData()
//        promise.add { result in
//
//            switch result {
//            case .success(let data): print(data)
//            case .failure(let error): print(error.localizedDescription)
//            }
//        }
        
        authorize(with: "test@test.com", password: "1234567")
            .flatMap { [weak self] token -> Future<Data> in
                return self?.fetchWeather(city: "Moscow", token: token) ?? Future<Data>()
            }
            .map { [weak self] data -> [Weather] in
                return self?.parse(data) ?? []
            }
            .add { result in
                switch result {
                case .success(let weathers): print(weathers)
                case .failure(let error): print(error)
                }
            }
        
    }
    
    func authorize(with email: String, password: String) -> Promise<String> {

        let promise = Promise<String>()
        //Запрос -> Токен
        DispatchQueue.global().async {
            promise.fulfill(with: "234sdfw34234sdfsdf32r2342sdfsdf")
        }
        return promise
    }
    
    func fetchWeather(city: String, token: String) -> Promise<Data> {

        let promise = Promise<Data>()
        DispatchQueue.global().async {
            promise.fulfill(with: Data())
        }
        return promise
    }
    
    func parse(_ data: Data) -> [Weather] {
        return [Weather(), Weather()]
    }
    
    
//    func fetchWeatherData() -> Promise<Data> {
//
//          // Создаем исходный промис, который будет возвращать
//          // Future<Data>, содержащую информацию о прогнозах погоды
//          let promise = Promise<Data>()
//
//          let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=Moscow&units=metric&appId=8b32f5f2dc7dbd5254ac73d984baf944")!
//
//          // Выполняем стандартный сетевой запрос
//          URLSession.shared.dataTask(with: url) { data, _, error in
//              // И в completion выполняем или нарушаем обещание
//              if let error = error {
//                  promise.reject(with: error)
//              } else {
//                  promise.fulfill(with: data ?? Data())
//              }
//          }.resume()
//
//          return promise
//
//      }

  
}
*/
