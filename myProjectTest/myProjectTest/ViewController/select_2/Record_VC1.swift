//
//  record_VC1.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/9.
//

import UIKit
import Firebase
import FirebaseFirestore

class Record_VC1: Select_VC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var myTableView: UITableView!
    @IBOutlet var mySegment: UISegmentedControl!
    
    let db = Firestore.firestore()
    var records = [Record]()
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getRecordInfo(state: index)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Select_2_Cell") as! Select_2_Cell
        cell.titleLabel.text = records[indexPath.section].initiator_name
        cell.detailLabel.text = dateToString(date: records[indexPath.section].time.dateValue())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "Record_VC2") as! Record_VC2
        print("indexPath: \(records[indexPath.section])")
        controller.documentIntitiates = records[indexPath.section].intitiatesId
        controller.result = records[indexPath.section].result
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func switchState(_ sender: UISegmentedControl) {
        index = sender.selectedSegmentIndex
        getRecordInfo(state: sender.selectedSegmentIndex)
        print("index: \(index)")
    }
    
    func getRecordInfo(state: Int) {
        records.removeAll()
        
        db.collection("records").whereField("user", isEqualTo: Global.user!).whereField("result", isEqualTo: state).getDocuments { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else{
                return
            }
            for document in querySnapshot.documents{
                print(document.documentID)
                print(document.data())
            }
            self.records = querySnapshot.documents.map {
                Record(dic: $0.data())
            }
            print("records: \(self.records)")
            self.myTableView.reloadData()
        }
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd -> HH:mm"
        
        return formatter.string(from: date)
    }
}
