//
//  VersuZoneVC.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/7.
//

import UIKit
import Firebase
import FirebaseFirestore

class VersusZoneVC: Select_VC {

    @IBOutlet var myTextField: UITextField!
    @IBOutlet var myTextView: UITextView!
    
    @IBOutlet var btn_scissors: UIButton!
    @IBOutlet var btn_rock: UIButton!
    @IBOutlet var btn_paper: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    let db = Firestore.firestore()
    
    /// 對戰資訊
    var initiateDetail: String?
    var initiateId: String?
    var initiator: String?
    var initiator_name: String?
    var initiatorActive: Int?
    var receiver: String?
    var time: Date?
    
    /// 結算 -> 0：和局、1：勝利、2：戰敗
    var receiverResult: Int?
    var initiatorResult: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        btn_scissors.layer.cornerRadius = btn_scissors.frame.height / 2
        btn_rock.layer.cornerRadius = btn_rock.frame.height / 2
        btn_paper.layer.cornerRadius = btn_paper.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTextField.text = initiator_name!
        myTextView.text = initiateDetail
        
        resultLabel.isHidden = true
        
        print("initiateId: \(initiateId)")
    }
    
    func lets_battle(send: Int) {
        switch send {
        case 0:
            if initiatorActive == 0 {
                receiverResult = 0
                initiatorResult = 0
            } else if initiatorActive == 1 {
                receiverResult = 2
                initiatorResult = 1
            } else if initiatorActive == 2 {
                receiverResult = 1
                initiatorResult = 2
            }
        case 1:
            if initiatorActive == 0 {
                receiverResult = 1
                initiatorResult = 2
            } else if initiatorActive == 1 {
                receiverResult = 0
                initiatorResult = 0
            } else if initiatorActive == 2 {
                receiverResult = 2
                initiatorResult = 1
            }
        case 2:
            if initiatorActive == 0 {
                receiverResult = 2
                initiatorResult = 1
            } else if initiatorActive == 1 {
                receiverResult = 1
                initiatorResult = 2
            } else if initiatorActive == 2 {
                receiverResult = 0
                initiatorResult = 0
            }
        default:
            break
        }
        
        showResult()
        settlement()
    }
    
    func showResult() {
        btn_rock.isHidden = true
        btn_paper.isHidden = true
        btn_scissors.isHidden = true
        
        resultLabel.isHidden = false
        
        if receiverResult == 0 {
            resultLabel.text = "平手！"
        } else if receiverResult == 1 {
            resultLabel.text = "獲勝！！"
        } else if receiverResult == 2 {
            resultLabel.textColor = .red
            resultLabel.text = "戰敗！！"
        }
    }
    
    func settlement() {
        let initiate_data: [String: Any] = ["initiateDetail": initiateDetail!,
                                            "initiator": initiator!,
                                            "initiator_name": initiator_name!,
                                            "initiatorActive": initiatorActive!,
                                            "receiver": receiver!,
                                            "time": time!,
                                            "state": false]
        
        let receiver_data: [String: Any] = ["user": receiver!,
                                            "user_name": Global.userName!,
                                            "result": receiverResult!,
                                            "intitiatesId": initiateId!,
                                            "initiator_name": initiator_name!,
                                            "time": time!]
        
        let initiator_data: [String: Any] = ["user": initiator!,
                                             "user_name": initiator_name!,
                                             "result": initiatorResult!,
                                             "intitiatesId": initiateId!,
                                             "initiator_name": Global.userName!,
                                             "time": time!]
        
        db.collection("initiates").document(initiateId!).setData(initiate_data)
        db.collection("records").addDocument(data: receiver_data)
        db.collection("records").addDocument(data: initiator_data)
    }
    
    @IBAction func click_scissors(_ sender: Any) {
        lets_battle(send: 0)
    }
    
    @IBAction func click_rock(_ sender: Any) {
        lets_battle(send: 1)
    }
    
    @IBAction func click_paper(_ sender: Any) {
        lets_battle(send: 2)
    }
}
