//
//  CreateEntryViewController.swift
//  Travelogue
//
//  Created by Weston Verhulst on 5/6/19.
//  Copyright © 2019 Weston Verhulst. All rights reserved.
//

import UIKit

class CreateEntryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    

    
    var entry: Entry?
    var trip: Trip?
    var image: UIImage?
    var date: Date?
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
        
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
        descriptionTextView.layer.cornerRadius = 6.0
        
        if let entry = entry {
            let name = entry.title
            titleTextField.text = name
            descriptionTextView.text = entry.content
            title = name
            datePicker.date = entry.modifiedDate!
            image = entry.imageModified
            imageView.image = image
        } else {
            titleTextField.text = ""
            descriptionTextView.text = ""
            imageView.image = nil
        }
        
        date = datePicker.date
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectImageSource() {
        let alert = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            (alertAction) in
            self.takePhotoUsingCamera()
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            (alertAction) in
            self.selectPhotoFromLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func takePhotoUsingCamera() {
        if (!UIImagePickerController.isSourceTypeAvailable(.camera)) {
            alertNotifyUser(message: "This device has no camera.")
            return
        }
        
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    func selectPhotoFromLibrary() {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        defer {
            imagePickerController.dismiss(animated: true, completion: nil)
        }
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        image = selectedImage
        imageView.image = image
        if let entry = entry {
            entry.imageModified = selectedImage
        }
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let name = titleTextField.text else {
            alertNotifyUser(message: "Entry not saved.\nThe name is not accessible.")
            return
        }
        
        let entryName = name.trimmingCharacters(in: .whitespaces)
        if (entryName == "") {
            alertNotifyUser(message: "Entry not saved.\nA name is required.")
            return
        }
        
        let content = descriptionTextView.text
        
        if entry == nil {
            if let trip = trip {
                entry = Entry(title: entryName, content: content, date: date ?? Date(timeIntervalSinceNow: 0), image: image, trip: trip)
            }
        } else {
            if let trip = trip {
                entry?.update(title: entryName, content: content, date: date!, image: image, trip: trip)
            }
        }
        
        if let entry = entry {
            do {
                let managedContext = entry.managedObjectContext
                try managedContext?.save()
            } catch {
                alertNotifyUser(message: "Entry not saved.\nAn error occured saving context.")
            }
        } else {
            alertNotifyUser(message: "Entry not saved.\nAn entry entity could not be created.")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nameChanged(_ sender: Any) {
        title = titleTextField.text
    }
    
    @IBAction func selectImage(_ sender: Any) {
        selectImageSource()
    }
    
    @IBAction func dateChanged(_ sender: Any) {
        date = datePicker.date
    }
    

}
