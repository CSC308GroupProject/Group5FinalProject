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
        
        guard let title = giftTitle.text, !title.isEmpty else {
            let alert = UIAlertController(
                title: "Title Needed",
                message: "Please enter a gift title before saving.",
                preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // If VC was called using "add" button, add new gift entry.
        if giftIndex != nil {
            mainVC?.giftArray[giftIndex!] = ((giftTitle.text ?? ""), giftDescription.text, giftHyperlink.text, giftImage.image)
        }
        // Otherwise VC was called by clicking a table section, update corresponding entry.
        else {
            mainVC?.giftArray.append((giftTitle.text ?? "", giftDescription.text, giftHyperlink.text, giftImage.image))
        }
        // Exit VC to caller VC.
        showConfettiBurst {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    private func showConfettiBurst(completion: @escaping () -> Void){
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.bounds.midX, y: -10)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: view.bounds.width, height: 1)
        
        let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple, .systemPink]
        
        emitter.emitterCells = colors.map { color in
            let cell = CAEmitterCell()
            cell.birthRate = 12
            cell.lifetime = 4.0
            cell.velocity = CGFloat.random(in: 200...400)
            cell.velocityRange = 100
            cell.emissionLongitude = CGFloat.pi
            cell.emissionRange = CGFloat.pi / 6
            cell.spin = 4
            cell.spinRange = 8
            cell.scale = 0.6
            cell.scaleRange = 0.3
            cell.color = color.cgColor
            cell.contents = makeConfettiImage()
            return cell
        }
        
        view.layer.addSublayer(emitter)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            emitter.birthRate = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            emitter.removeFromSuperlayer()
            completion()
        }
    }
    
    private func makeConfettiImage() -> CGImage? {
        let size = CGSize(width: 10, height: 6)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.setFill()
        UIBezierPath(roundedRect:CGRect(origin: .zero, size: size), cornerRadius: 2).fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.cgImage
        
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

