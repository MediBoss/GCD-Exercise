//
//  ImageDownloadService.swift
//  GDC-Exercise
//
//  Created by Medi Assumani on 6/1/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

struct ImageDownloadService{
    
    static let shared = ImageDownloadService()
    let imageDownloadSession = URLSession(configuration: .default)
    
    func makeNormalRequest(urls: [String], completion: @escaping([UIImage]) -> ()){
        
        var downloadedImages = [UIImage]()
        urls.forEach { (urlString) in
            
            let url = URL(string: urlString)!
            imageDownloadSession.dataTask(with: url, completionHandler: { (data, res, err) in
                
                if err == nil {
                    
                    guard let unwrappedData = data else { return }
                    guard let image = UIImage(data: unwrappedData) else { return }
                    downloadedImages.append(image)
                }
            }).resume()
        }
    }
    
    func makeConcurentRequest(urls: [String] ,completion: @escaping([UIImage]) -> ()) {
        
        let group = DispatchGroup()
        var downloadedImages = [UIImage]()
        
        urls.forEach { (urlString) in
            
            group.enter()
            let url = URL(string: urlString)!
            imageDownloadSession.dataTask(with: url, completionHandler: { (data, res, err) in
                
                if err == nil {
                    
                    guard let unwrappedData = data else { return }
                    guard let image = UIImage(data: unwrappedData) else { return }
                    downloadedImages.append(image)
                    group.leave()
                }
            }).resume()
        }
        
        group.notify(queue: .main) {
            completion(downloadedImages)
        }
    }
}
