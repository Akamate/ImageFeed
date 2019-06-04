//
//  ImageFeedViewController.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 4/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import UIKit
import RealmSwift

class ImageFeedViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource
{
    
    let realm = try! Realm()
    let imagePicker = UIImagePickerController()
    var images : Results<ImageFeed>?
//    var images : [UIImage] = []
    @IBOutlet var imageFeedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFeedTableView.delegate = self
        imageFeedTableView.dataSource = self
//        configureTableView()
//        loadImage()
        // Do any additional setup after loading the view.
    }
    //Config TableView
    func configureTableView(){
        imageFeedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCell")
        imageFeedTableView.rowHeight = 190
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0//images?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("test test")
        let cell = imageFeedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        if let myFeed = self.images?[indexPath.row] as? UIImage  {
            cell.date.text = "hello"//myFeed.date
//            if let photo = myFeed.myImage {
//                cell.myImage.image = UIImage(data: photo as Data)
//            }
        }
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy"
//        let result = formatter.string(from: date)
//        cell.myImage.image = images[indexPath.row]
//        cell.date.text = result
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //Take photo button
    @IBAction func takePhoto(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Get image info
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        print("take photo")
        guard let takedImage = info[.originalImage] as? UIImage else{
            print("image not found")
            return
        }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
       
        let imageFeed = ImageFeed()
        imageFeed.date = result
        if let image = takedImage.pngData(){
            imageFeed.myImage = image as NSData
        }

        saveImageFeed(imageFeed: imageFeed)
      //  images.append(takedImage)
        self.imageFeedTableView.reloadData()
    }
    
    func loadImage(){
        images = realm.objects(ImageFeed.self)
        self.imageFeedTableView.reloadData()
    }

    func saveImageFeed(imageFeed : ImageFeed){
//        do{
//            try realm.write {
//                realm.add(imageFeed)
//            }
//
//        }
//        catch{
//            print("Failed Saving Data \(error)")
//        }
//        self.imageFeedTableView.reloadData()
    }
}

//extension ImageFeedViewController : UITableViewDelegate,UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return images.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = imageFeedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
//        cell.textLabel?.text = "Hi"
//        cell.myImage.image = images[indexPath.row]
//        print(images.count)
//        return cell
//    }
//
//
//}
