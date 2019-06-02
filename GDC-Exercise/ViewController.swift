//
//  ViewController.swift
//  GDC-Exercise
//
//  Created by Medi Assumani on 5/31/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var maintableview: UITableView!
    var imageURLs = ["https://homepages.cae.wisc.edu/~ece533/images/airplane.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/peppers.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/boat.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/cat.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/watch.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/monarch.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/fruits.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/frymire.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/pool.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/serrano.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/tulips.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/goldhill.png",
                     "https://homepages.cae.wisc.edu/~ece533/images/barbara.png"
    ]
    
    
    var images = [UIImage](){
        didSet{
            DispatchQueue.main.async {
                self.maintableview.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ImageDownloadService.shared.makeNormalRequest(urls: self.imageURLs) { (imgs) in
//            self.images = imgs
//        }
        ImageDownloadService.shared.makeConcurentRequest(urls: imageURLs) { (imgs) in
            self.images = imgs
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = maintableview.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! ImageCell
        
        cell.imageview.image = self.images[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

