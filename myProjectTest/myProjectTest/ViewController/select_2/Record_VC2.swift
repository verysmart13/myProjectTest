//
//  Record_VC2.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/9.
//

import UIKit
import Firebase
import FirebaseFirestore

class Record_VC2: Select_VC {

    @IBOutlet var initiatorLabel: UITextField!
    @IBOutlet var initiatorDetail: UITextView!
    @IBOutlet var resultLabel: UITextField!
    
    let db = Firestore.firestore()
    var initiates: [String: Any]?
    var documentIntitiates: String = ""
    var result: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        db.collection("initiates").document(documentIntitiates).getDocument { (documentSnapshot, error) in
            
            self.initiates = documentSnapshot?.data()
            self.initiatorLabel.text = self.initiates?["initiator_name"] as? String
            self.initiatorDetail.text = self.initiates?["initiateDetail"] as? String
            print("initiates: \(self.initiates)")
        }
        
        if result == 0 {
            resultLabel.text = "平手，再來一局！"
        } else if result == 1 {
            resultLabel.text = "獲勝，可以輕鬆一下！"
        } else if result == 2 {
            resultLabel.textColor = .red
            resultLabel.text = "戰敗，乖乖認命吧！"
        }
    }
}
