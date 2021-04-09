//
//  InsertNameTV.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/9.
//

import UIKit

class InsertNameTV: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "showInsertNameTV"), object: nil)
    }

    // MARK: - Table view data source
    
    @objc func reloadData() {
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SendChallenge_VC1.users_id.count 
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "InsertNameCell") as! InsertNameCell
        cell.titleLabel.text = SendChallenge_VC1.user_names[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SendChallenge_VC1.user_name = SendChallenge_VC1.user_names[indexPath.row]
        SendChallenge_VC1.user_id = SendChallenge_VC1.users_id[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("SendChallenge_VC1_setReceiver"), object: nil)
    }
}
