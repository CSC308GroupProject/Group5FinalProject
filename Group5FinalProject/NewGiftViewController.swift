//
//  NewGiftViewController.swift
//  Group5FinalProject
//
//  Created by Brayden Peeples on 4/7/26.
//

import UIKit

class NewGiftViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var listVC: ViewController?
    
    @IBOutlet weak var giftTitle: UITextField!
    @IBOutlet weak var giftDescription: UITextView!
    @IBOutlet weak var giftHyperlink: UITextField!
    @IBOutlet weak var giftImage: UIImageView!
    @IBAction func selectImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        giftImage.image = image
        
        dismiss(animated: true)
    }
    
}

