//
//  ImageFeedViewModel.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 5/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import Foundation
import RealmSwift

final class ImageFeedViewModel {
    private let realm = try! Realm()
    
    var images: Results<ImageFeed>?
    var imageList = ImageList()
    var numberOfImages: Int {
        return images?.count ?? 0
    }
    
    func loadImage(){
         images = realm.objects(ImageFeed.self)
    }
    
    func saveImageFeed(myImage : UIImage){
        let imageFeed = ImageFeed()
        imageFeed.date = calculateDate()
        
        if let image = myImage.jpegData(compressionQuality: 0.7) {
            imageFeed.myImage = image as NSData
        }
        
        do {
            try realm.write {
                realm.add(imageFeed)
            }
        } catch {
            print("Failed Saving Data \(error)")
        }
    }
    
    func deleteImage(indexPath : IndexPath){
        if let myImage = images?[indexPath.row]{
            do {
                try realm.write {
                    realm.delete(myImage)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func calculateDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let result = formatter.string(from: date)
        return result
    }
}
