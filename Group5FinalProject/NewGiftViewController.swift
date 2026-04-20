//
//  NewGiftViewController.swift
//  Group5FinalProject
//
//  Created by Brayden Peeples on 4/7/26.
//

import UIKit

class NewGiftViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // References assigned by main viewController when table cell is clicked.
    var mainVC: ViewController?
    var giftIndex: Int?
    
    var titleVar: String?
    var descriptionVar: String?
    var hyperlinkVar: String?
    var imageVar: UIImage?
    
    var deleteHidden = true
    
    
    // Action performed when "done" button is clicked.
    @IBAction func doneButton(_ sender: Any) {
        
        /*
         
         CHECK HERE IF GIFTTITLE IS ASSIGNED A VALUE
         CALL UIALERT IF NOT
         
         */
        
        // If VC was called using "add" button, add new gift entry.
        if giftIndex != nil {
            mainVC?.giftArray[giftIndex!] = ((giftTitle.text ?? ""), giftDescription.text, giftHyperlink.text, giftImage.image)
        }
        // Otherwise VC was called by clicking a table section, update corresponding entry.
        else {
            mainVC?.giftArray.append((giftTitle.text ?? "", giftDescription.text, giftHyperlink.text, giftImage.image))
        }
        // Exit VC to caller VC.
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBOutlet weak var deleteButton: UIButton!
    
    // Action performed when "delete" button is clicked.
    @IBAction func deleteButton(_ sender: Any) {
        // Remove the current gift entry from giftArray.
        mainVC?.giftArray.remove(at: giftIndex!)
        // Exit VC to caller VC.
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var giftTitle: UITextField!
    @IBOutlet weak var giftDescription: UITextView!
    @IBOutlet weak var giftHyperlink: UITextField!
    @IBOutlet weak var giftImage: UIImageView!
    
    // "Select Image" button clicked, open image picker.
    @IBAction func selectImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    // Function to set giftImage with the chosen image once image picker is used.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        giftImage.image = image
        
        dismiss(animated: true)
    }
    
    // Assign values provided by caller VC on load.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteButton.isHidden = deleteHidden
        giftTitle.text = titleVar
        giftDescription.text = descriptionVar
        giftHyperlink.text = hyperlinkVar
        giftImage.image = imageVar
    }
    
    
}

