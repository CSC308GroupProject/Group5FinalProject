//
//  ViewController.swift
//  Group5FinalProject
//
//  Created by Brayden Peeples on 4/7/26.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    
    // Gift Entry contains these items:
    // Title
    // Description
    // Hyperlink
    // Image?
    var giftArray: [(title: String, description: String?, link: String?, image: UIImage?)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set initial settings for tableView.
        mainTable.delegate = self
        mainTable.backgroundView = UIImageView(image: UIImage(named: "marble-tile"))
        mainTable.backgroundView?.alpha = 0.5
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // Reload table data when this viewController reappears.
        mainTable.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass reference to this VC on segue to NewGiftViewController.
        if let vc = segue.destination as? NewGiftViewController {
            vc.mainVC = self
            // If sender is a table cell, send information about table section and modify VC.
            if let cell = sender as? UITableViewCell {
                vc.navigationItem.title = "Viewing Gift Entry"
                vc.deleteHidden = false
                
                let section = mainTable.indexPath(for: cell)?.section
                vc.giftIndex = section
                
                vc.titleVar = giftArray[section!].title
                vc.descriptionVar = giftArray[section!].description
                vc.hyperlinkVar = giftArray[section!].link
                vc.imageVar = giftArray[section!].image
            }
        }
        
    }
    
}

// Extension to work with all tableView and related functions.
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // Get number of sections needed to cover giftArray.
    func numberOfSections(in tableView: UITableView) -> Int {
        return giftArray.count
    }
    
    // Get the number of rows needed per section (four).
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // Set custom height for image rows, dynamic height for other rows.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 200
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
    // Set table data given data from giftArray.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        // Ensure no data is leftover from previous calls to this func.
        cell.imageView?.image = nil
        cell.textLabel?.text = nil
        
        // Perform different actions based on current row number.
        switch indexPath.row {
        // Assign gift title.
        case 0:
            let item = giftArray[indexPath.section].0
            cell.textLabel?.text = item
        // Assign gift description.
        case 1:
            var text = "Description:\n"
            guard let item = giftArray[indexPath.section].1, item != "" else {
                text += "none"
                cell.textLabel?.text = text
                break
            }
            text += item
            cell.textLabel?.text = text
        // Assign gift hyperlink.
        case 2:
            var text = "Hyperlink:\n"
            guard let item = giftArray[indexPath.section].2, item != "" else {
                text += "none"
                cell.textLabel?.text = text
                break
            }
            text += item
            cell.textLabel?.text = text
        // Assign gift image.
        case 3:
            guard let image = giftArray[indexPath.section].3 else {
                let text = "Image:\nnone"
                cell.textLabel?.text = text
                break
            }
            print("image set")
            cell.imageView?.image = image
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView?.clipsToBounds = true
        default:
            break
        }
        return cell
    }
    
}


