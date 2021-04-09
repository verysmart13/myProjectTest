//
//  SendChallenge_VC2.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/7.
//

import UIKit
import Firebase
import FirebaseFirestore

class SendChallenge_VC2: Select_VC {
    
    let db = Firestore.firestore()
    
    var initiateDetail: String?
    var initiator: String?
    var initiator_name: String?
    var receiver: String?
    
    @IBOutlet var btn_scissors: UIButton!
    @IBOutlet var btn_rock: UIButton!
    @IBOutlet var btn_paper: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        btn_scissors.layer.cornerRadius = btn_scissors.frame.height / 2
        btn_rock.layer.cornerRadius = btn_rock.frame.height / 2
        btn_paper.layer.cornerRadius = btn_paper.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("info: \(initiateDetail!), \(initiator!), \(initiator_name!), \(receiver!)")
    }
    
    @IBAction func send_scissors(_ sender: Any) {
        setResult(initiatorActive: 0)
    }
    
    @IBAction func send_rock(_ sender: Any) {
        setResult(initiatorActive: 1)
    }
    
    @IBAction func send_paper(_ sender: Any) {
        setResult(initiatorActive: 2)
    }
    
    func setResult(initiatorActive: Int) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SendChallenge_FinishVC") as! SendChallenge_FinishVC
        let initiate_data: [String: Any] = ["initiateDetail": initiateDetail!,
                                            "initiator": initiator!,
                                            "initiator_name": initiator_name!,
                                            "initiatorActive": initiatorActive,
                                            "receiver": receiver!,
                                            "time": Date(),
                                            "state": true]
        
        db.collection("initiates").addDocument(data: initiate_data)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
