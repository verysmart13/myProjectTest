//
//  GetInitiatesVC.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/8.
//

import UIKit
import Firebase
import FirebaseFirestore

class GetInitiatesVC: Select_3_TV {

    let db = Firestore.firestore()
    var initiates = [Initiate]()
    var initiate_id = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getInitiateInfo()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        initiates.removeAll()
        initiate_id.removeAll()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return initiates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Select_3_Cell", for: indexPath) as! Select_3_Cell
        
        cell.titleLabel.text = initiates[indexPath.row].initiator_name
        cell.detailLabel.text = "發起一項挑戰"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "VersusZoneVC") as! VersusZoneVC
        
        controller.initiateId = initiate_id[indexPath.row]
        controller.initiateDetail = initiates[indexPath.row].initiateDetail
        controller.initiator = initiates[indexPath.row].initiator
        controller.initiatorActive = initiates[indexPath.row].initiatorActive
        controller.initiator_name = initiates[indexPath.row].initiator_name
        controller.receiver = initiates[indexPath.row].receiver
        controller.time = initiates[indexPath.row].time
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func getInitiateInfo() {
        db.collection("initiates").whereField("receiver", isEqualTo: Global.user!).whereField("state", isEqualTo: true).getDocuments { (querySnapshot, error) in
            
            guard let querySnapshot = querySnapshot else{
                return
            }
            for document in querySnapshot.documents{
                self.initiate_id.append(document.documentID)
                print(document.documentID)
                print(document.data())
            }
            self.initiates = querySnapshot.documents.map {
                Initiate(dic: $0.data())
            }
            
            self.tableView.reloadData()
        }
    }
}
