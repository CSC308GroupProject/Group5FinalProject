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
    
    let gift1 = ("Test Gift 1", "This is a test gift 1", nil as String?, UIImage(named: "marble-tile"))
    let gift2 = ("Test Gift 2", "This is a test gift 2", "https://www.apple.com", nil as UIImage?)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainTable.delegate = self
        
        mainTable.backgroundView = UIImageView(image: UIImage(named: "marble-tile"))
        mainTable.backgroundView?.alpha = 0.5
        
    }
    override func viewWillAppear(_ animated: Bool) {
        mainTable.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewGiftViewController {
            vc.mainVC = self
            if let cell = sender as? UITableViewCell {
                vc.navigationItem.title = "Viewing Gift Entry"
                vc.deleteHidden = false
                let section = mainTable.indexPath(for: cell)?.section
                vc.titleVar = giftArray[section!].title
                vc.descriptionVar = giftArray[section!].description
                vc.hyperlinkVar = giftArray[section!].link
                vc.imageVar = giftArray[section!].image
            }
        }
        
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let section = indexPath.section
//        print("Section Clicked: \(section)")
//    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return giftArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("Number of rows: \(giftArray.count)")
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 200
        }
        else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        //cell.imageView?.image = giftArray[indexPath.section].3
        switch indexPath.row {
        case 0:
            let item = giftArray[indexPath.section].0
            cell.textLabel?.text = item
        case 1:
            var text = "Description:\n"
            guard let item = giftArray[indexPath.section].1 else {
                text += "none"
                cell.textLabel?.text = text
                break
            }
            text += item
            cell.textLabel?.text = text
        case 2:
            var text = "Hyperlink:\n"
            guard let item = giftArray[indexPath.section].2 else {
                text += "none"
                cell.textLabel?.text = text
                break
            }
            text += item
            cell.textLabel?.text = text
        case 3:
            guard let item = giftArray[indexPath.section].3 else {
                let text = "no image"
                cell.textLabel?.text = text
                break
            }
            cell.imageView?.image = item
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView?.clipsToBounds = true
        default:
            break
        }
        
        print ("Cell for row: \(indexPath.section)")
        return cell
    }
    
    
    
}


