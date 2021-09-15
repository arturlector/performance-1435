//
//  GCDViewController.swift
//  performance-1435
//
//  Created by Artur Igberdin on 14.09.2021.
//

import UIKit
import CoreImage

class GCDViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        blurImages()
        
        //testAsyncGlobal()
        
        //testMainQueue()
        
        //testGlobalQueueSync()
        
        //firstMethod()
        
        //secondMethod()
        
        //thirdMethod()
        
        //fourthMethod()
    }
    
    func fourthMethod() {
        print("A")
        
        DispatchQueue.main.async {
            print("B")
            
            DispatchQueue.main.async {
                print("С")
                
                DispatchQueue.main.async {
                    print("D")
                    
                    DispatchQueue.main.async {
                           print("E")
                    }
                }
            }
            
            DispatchQueue.global().sync {
                print("F")
                
                DispatchQueue.global().sync {
                    print("G")
                }
            }
            print("H")
        }
        
        print("I")
    }
    
    func thirdMethod() {
        print("A")
        
        DispatchQueue.main.async {
            print("B")
            
            DispatchQueue.main.async {
                print("С")
                
                DispatchQueue.main.async {
                    print("D")
                    
                    DispatchQueue.main.async {
                           print("E")
                    }
                }
            }
            
            //Кастомная - последовательной
            let queue = DispatchQueue.init(label: "queue1", qos: .background)
            queue.sync {
                print("F")
                
                queue.sync {
                    print("G")
                }
            }
            print("H")
        }
        
        print("I")
    }
    
    func secondMethod() {
        print("A")
        
        DispatchQueue.main.async {
            print("B")
            
            DispatchQueue.main.async {
                print("С")
                
                DispatchQueue.main.async {
                    print("D")
                    
                    DispatchQueue.main.async {
                           print("E")
                    }
                }
            }
            
            DispatchQueue.global().sync {
                print("F")
                
                DispatchQueue.main.sync {
                    print("G")
                }
            }
            print("H")
        }
        
        print("I")
    }
    
    func firstMethod() {
        print("A")

        DispatchQueue.main.async {
            print("B")

            DispatchQueue.main.async {
                print("C")
            }
            DispatchQueue.main.async {
                print("D")
            }
            DispatchQueue.global().sync {
                print ("E")
            }
        }

        print("F")

        DispatchQueue.main.async {
            print("G")

        }
    }

    
    func testGlobalQueueSync() {
        
//        DispatchQueue.global(qos: .userInteractive).async {
//            print("😇")
//        }
        
        print("😇")
        
        DispatchQueue.global().sync {
            print("😈")
        }
        
        DispatchQueue.global().sync {
            print("🥶")
        }
        
//        DispatchQueue.main.async {
//            print("😇")
//        }
                
        print("😇")
        
        
        
    }
    
    func testMainQueue() {
//        DispatchQueue.main.async { print("H") }
//        DispatchQueue.main.async { print("e") }
//        DispatchQueue.main.async { print("l") }
//        DispatchQueue.main.async { print("l") }
//        DispatchQueue.main.async { print("o") }
        
        DispatchQueue.global().async { print("H") }
        DispatchQueue.global().async { print("e") }
        DispatchQueue.global().async { print("l") }
        DispatchQueue.global().async { print("l") }
        DispatchQueue.global().async { print("o") }
    }
    
    func testAsyncGlobal() {
        
       
        DispatchQueue.main.async {
            for _ in (0..<1000) {
                print("😇")
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            for _ in (0..<1000) {
                print("😈")
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            for _ in (0..<1000) {
                print("👻")
            }
        }

        DispatchQueue.global(qos: .utility).async {
            for _ in (0..<1000) {
                print("👽")
            }
        }
        
        
       
    }

    // MARK: - Table view data source

    var images = [
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!
        ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                
        cell.imageView?.image = images[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func blurImages() {
            var bluredImages = images
            let dispatchGroup = DispatchGroup()
            
            for element in bluredImages.enumerated() {
                
                DispatchQueue.global().async(group: dispatchGroup) {
                    
                    let inputImage = element.element
                    let inputCIImage = CIImage(image: inputImage)!
                    
                    let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: [kCIInputImageKey: inputCIImage])!
                    
                    //let blurFilter = CIFilter(name: "CIGaussianBlur", withInputParameters: [kCIInputImageKey: inputCIImage])!
                    let outputImage = blurFilter.outputImage!
                    let context = CIContext()
                    
                    let cgiImage = context.createCGImage(outputImage, from: outputImage.extent)
                    
                    bluredImages[element.offset] = UIImage(cgImage: cgiImage!)
                }
                
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                self.images = bluredImages
                self.tableView.reloadData()
            }
            
    }
    

    

}
