//
//  InfoTableViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 20.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var yearTextLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let statusIdentifier = "statusCell"
    let mainInfoIdentifier = "mainInfoCell"
    
    let cellsInfo: [String:String] = ["StatusTableViewCell":"statusCell", "MainInfoTableViewCell":"mainInfoCell"]
    
    let numberOfRowsAtSection = [1, 6]
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = user.name
        
        fillLabels(with: user)
        registerCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - setting UI information
    
    private func fillLabels(with user: User) {
        let seperator = ","
        
        avatarImageView.roundCorners()
        avatarImageView.image = user.profileImage
        nameLabel.text = "\(user.name) \(user.surname)"
        statusLabel.text = user.onlineStatus.rawValue
        yearsLabel.text = "\(user.age)"
        yearTextLabel.text = EndingWord.getCorrectEnding(with: user.age, and: DeclinationWordDictionary.age) + seperator
        cityLabel.text = user.city
    }
    
    private func registerCells() {
        for (fileName, cellIdentifier) in cellsInfo {
            let nib = UINib(nibName: fileName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return cellsInfo.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        
        if (section < numberOfRowsAtSection.count) {
            rows = numberOfRowsAtSection[section]
        }
        
        return rows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifiers = Array(cellsInfo.values)
        let cellIdentifier = cellIdentifiers[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let userInfo = user.info
        
        switch indexPath.section {
        case 0:
            let statusCell = cell as! StatusTableViewCell
            statusCell.prepareCell(with: userInfo.status)
            return statusCell
        case 1:
            let mainInfoCell = cell as! MainInfoTableViewCell
            mainInfoCell.prepareCell(with: userInfo.mainInfo, position: indexPath.row)
            return mainInfoCell
        default:
            break
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
