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
    
    let cellsInfo = [
        CellInfo(fileName: "StatusTableViewCell", identifier: "statusCell"),
        CellInfo(fileName: "MainInfoTableViewCell", identifier: "mainInfoCell"),
        CellInfo(fileName: "ContactTableViewCell", identifier: "contactCell"),
        CellInfo(fileName: "ProfessionTableViewCell", identifier: "professionCell"),
        CellInfo(fileName: "InstituteTableViewCell", identifier: "instituteCell"),
        CellInfo(fileName: "PresentTableViewCell", identifier: "presentCell"),
        CellInfo(fileName: "OtherInfoTableViewCell", identifier: "otherInfoCell")
    ]
    let schoolCellInfo = CellInfo(fileName: "SchoolTableViewCell", identifier: "schoolCell")
    
    var numberOfRowsAtSection = [Int]()
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = user.name
        
        fillLabels(with: user)
        registerNumberOfRowsAtSection()
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
        for i in 0 ..< cellsInfo.count {
            let cellInfo = cellsInfo[i]
            let nib = UINib(nibName: cellInfo.fileName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellInfo.identifier)
        }
        
        let nib = UINib(nibName: schoolCellInfo.fileName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: schoolCellInfo.identifier)
    }
    
    private func registerNumberOfRowsAtSection() {
        let userInfo = user.info
        let userEducation = userInfo.education
        let statusCountRow = 1
        let presentsCountRow = 1
        numberOfRowsAtSection.append(statusCountRow)
        numberOfRowsAtSection.append(userInfo.main.count)
        numberOfRowsAtSection.append(userInfo.contacts.count)
        numberOfRowsAtSection.append(userInfo.professions.count)
        numberOfRowsAtSection.append(userEducation.institutes.count + userEducation.schools.count)
        numberOfRowsAtSection.append(presentsCountRow)
        numberOfRowsAtSection.append(userInfo.others.count)
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
        let section = indexPath.section
        let row = indexPath.row
        
        let userInfo = user.info
        
        switch section {
        case 0:
            let statusCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! StatusTableViewCell
            statusCell.prepareCell(with: userInfo.status)
            return statusCell
        case 1:
            let mainInfoCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! MainInfoTableViewCell
            mainInfoCell.prepareCell(with: userInfo.main[row])
            return mainInfoCell
        case 2:
            let contactCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! ContactTableViewCell
            contactCell.prepareCell(with: userInfo.contacts[row])
            return contactCell
        case 3:
            let professionCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! ProfessionTableViewCell
            professionCell.prepareCell(with: userInfo.professions[row])
            return professionCell
        case 4:
            let instituteCount = userInfo.education.institutes.count
            if row < instituteCount {
                let instituteCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! InstituteTableViewCell
                instituteCell.prepareCell(with: userInfo.education.institutes[row])
                return instituteCell
            } else {
                let schoolCell = tableView.dequeueReusableCell(withIdentifier: schoolCellInfo.identifier, for:indexPath) as! SchoolTableViewCell
                schoolCell.prepareCell(with: userInfo.education.schools[row - instituteCount])
                return schoolCell
            }
        case 5:
            let presentCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! PresentTableViewCell
            presentCell.prepareCell(with: userInfo.presents)
            return presentCell
        case 6:
            let otherInfoCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! OtherInfoTableViewCell
            otherInfoCell.prepareCell(with: userInfo.others[row])
            return otherInfoCell
        default:
            break
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let professionSection = 3
        let educationSection = 4
        let presentSection = 5
        let professionHeight: CGFloat = 92
        let instituteHeight: CGFloat = 166
        let schoolHeight: CGFloat = 172
        let presentHeight: CGFloat = 120
        let defaultHeight: CGFloat = 44
        
        if (indexPath.section == professionSection) {
            return professionHeight
        } else if (indexPath.section == educationSection) {
            if indexPath.row == 0 {
                return instituteHeight
            } else {
                return schoolHeight
            }
        } else if (indexPath.section == presentSection) {
            return presentHeight
        }
        return defaultHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let contacts = "контакты"
        let career = "карьера"
        let education = "образование"
        
        switch section {
            case 2: return contacts
            case 3: return career
            case 4: return education
            default: return ""
        }
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
