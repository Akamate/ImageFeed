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
    @IBOutlet var imageFeedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFeedTableView.delegate = self
        imageFeedTableView.dataSource = self
        configureTableView()
        loadImage()
       // scrollToBottom()
        // Do any additional setup after loading the view.
    }
    //Config TableView
    func configureTableView(){
        imageFeedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCell")
        imageFeedTableView.rowHeight = 190
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = imageFeedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        if let myFeed = self.images?[indexPath.row]  {
            cell.date.text = myFeed.date
            if let photo = myFeed.myImage {
                cell.myImage.image = UIImage(data: photo as Data)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoImage", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ImageViewController
        if let indexPath = imageFeedTableView.indexPathForSelectedRow {
            if let photo = images?[indexPath.row].myImage {
                destinationVC.newImage = UIImage(data: photo as Data)
            }
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.deleteImage(indexPath:indexPath)
            self.imageFeedTableView.reloadData()
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false

        return swipeActionConfig
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
        guard let takedImage = info[.originalImage] as? UIImage else{
            print("image not found")
            return
        }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let result = formatter.string(from: date)
       
        let imageFeed = ImageFeed()
        imageFeed.date = result
        if let image = takedImage.jpegData(compressionQuality: 0.7){
            imageFeed.myImage = image as NSData
        }

        saveImageFeed(imageFeed: imageFeed)
        self.imageFeedTableView.reloadData()
        scrollToBottom()
    }
    //loadImage
    func loadImage(){
        images = realm.objects(ImageFeed.self)
        self.imageFeedTableView.reloadData()
        
        
    }
    //saveImage
    func saveImageFeed(imageFeed : ImageFeed){
        do{
            try realm.write {
                realm.add(imageFeed)
            }

        }
        catch{
            print("Failed Saving Data \(error)")
        }
        self.imageFeedTableView.reloadData()
    }
    func deleteImage(indexPath : IndexPath){
        if let myImage = images?[indexPath.row]{
            do{
                try realm.write {
                    realm.delete(myImage)
                }
            }
            catch {
                print(error)
            }
        }
    }
    func scrollToBottom(){
        if let numofImage = images?.count {
            if(numofImage>0){
                self.imageFeedTableView.scrollToRow(at: IndexPath(row: numofImage-1, section: 0), at: .bottom, animated: false)
            }
        }
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
