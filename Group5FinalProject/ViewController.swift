//
//  ViewController.swift
//  Group5FinalProject
//
//  Created by Brayden Peeples on 4/7/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    
    // Gift Entry contains these items:
    // Title
    // Description
    // Hyperlink
    // Image?
    var giftArray: [(title: String, description: String, link: String, image: UIImage?)] = []
    
    let gift1 = ("Test Gift 1", "This is a test gift 1", "https://www.google.com", nil as UIImage?)
    let gift2 = ("Test Gift 2", "This is a test gift 2", "https://www.apple.com", nil as UIImage?)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainTable.backgroundView = UIImageView(image: UIImage(named: "marble-tile"))
        mainTable.backgroundView?.alpha = 0.5
        
        
        giftArray = [gift1, gift2]
        
        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return giftArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("Number of rows: \(giftArray.count)")
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(giftArray[indexPath.section].0)"
        cell.imageView?.image = giftArray[indexPath.section].3
        print ("Cell for row: \(indexPath.section)")
        return cell
    }
    
}
