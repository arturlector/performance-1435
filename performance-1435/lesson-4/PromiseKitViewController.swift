//
//  PromiseKitViewController.swift
//  performance-1435
//
//  Created by Artur Igberdin on 24.09.2021.
//

import UIKit
import PromiseKit
import Alamofire

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
}

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

enum ApplicationError: Error {
    case noUsers
    case noPosts
    case postsCouldNotBeParsed
}

class PromiseKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllUsers()
            .then { users -> Promise<[Post]> in
                print(users)
                let user = users.first
                return getPosts(for: user?.id ?? 0)
            }
            .then({ posts -> Promise<[Post]> in
                return getPosts(for: 3)
            })
            .done { post in
                
                //UI
                print("post", post)
            }
            .catch { error in
                print(error)
            }
        
    }
}

func getAllUsers() -> Promise<[User]> {
    
    let (promise, resolver) = Promise<[User]>.pending()
    
    let url = "https://jsonplaceholder.typicode.com/users"
    
    AF.request(url).responseJSON { response in
        
        if let error = response.error {
            resolver.reject(error)
        }
        
        if let data = response.data {
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                resolver.fulfill(users)
            } catch {
                resolver.reject(ApplicationError.noUsers)
            }
        }
    }
    return promise
}

func getPosts(for userId: Int) -> Promise<[Post]> {
    
    let (promise, resolver) = Promise<[Post]>.pending()
    
    let url = "https://jsonplaceholder.typicode.com/posts"
    
    AF.request(url).responseJSON { response in
        
        if let error = response.error {
            resolver.reject(error)
        }
        
        if let data = response.data {
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                resolver.fulfill(posts)
                
            } catch {
                resolver.reject(ApplicationError.noPosts)
            }
        }
    }
    return promise
}
