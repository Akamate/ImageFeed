//
//  ImageFeedViewController.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 4/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import UIKit

final class ImageFeedViewController: UIViewController {
    lazy var imageFeedVM: ImageFeedViewModel = {
        return ImageFeedViewModel()
    }()
    
    private let nameOfView: String = "MyFeed"
    private lazy var imagePicker = UIImagePickerController()
    
    @IBOutlet private var imageFeedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        imageFeedVM.loadImage()
       // setNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationItem()
    }
    
    private func configureTableView(){
        imageFeedTableView.separatorStyle = .none
        imageFeedTableView.delegate = self
        imageFeedTableView.dataSource = self
        imageFeedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCell")
        imageFeedTableView.rowHeight = 190.0
    }
    
    private func setNavigationItem(){
        self.tabBarController?.navigationItem.title = nameOfView
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutPressed))
      //  self.tabBarController?.navigationItem.leftBarButtonItem = editButtonItem
       // self.tabBarController?.navigationItem.leftBarButtonItem?.action = #selector(editButtonPressed)
    }
    
    @objc private func logoutPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func editButtonPressed() {
        self.tabBarController?.navigationItem.leftBarButtonItem?.title =  imageFeedTableView.isEditing ? "Edit" : "Done"
        imageFeedTableView.isEditing = !imageFeedTableView.isEditing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ImageViewController
        if let indexPath = imageFeedTableView.indexPathForSelectedRow {
            if let photo = imageFeedVM.images?[indexPath.row].myImage {
                destinationVC.newImage = UIImage(data: photo as Data)
            }
        }
    }
}

extension ImageFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageFeedVM.numberOfImages
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = imageFeedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        if let myFeed = imageFeedVM.images?[indexPath.row]  {
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
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, nil) in
            self.imageFeedVM.deleteImage(indexPath:indexPath)
            self.imageFeedTableView.reloadData()
        }
        delete.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        return swipeActionConfig
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("source: \(sourceIndexPath) dest : \(destinationIndexPath)")
    }
}

extension ImageFeedViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   //Take photo button
    @IBAction private func takePhoto(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.showsCameraControls = true
        present(imagePicker, animated: true, completion: nil)
    }
    //Get image info
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let takedImage = info[.originalImage] as? UIImage else { return }
        imageFeedVM.saveImageFeed(myImage: takedImage)
        imageFeedTableView.reloadData()
        scrollToBottom()
    }
    
    private func scrollToBottom() {
            if(imageFeedVM.numberOfImages>0){
                self.imageFeedTableView.scrollToRow(at: IndexPath(row: imageFeedVM.numberOfImages-1, section: 0), at: .bottom, animated: false)
        }
    }
}
