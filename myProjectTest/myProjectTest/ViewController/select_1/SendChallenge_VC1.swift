//
//  SendChallenge_VC1.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/7.
//

import UIKit
import Firebase
import FirebaseFirestore

class SendChallenge_VC1: Select_VC, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet var myTextField: UITextField!
    @IBOutlet var myTextView: UITextView!
    
    @IBOutlet var myContantView: UIView!
    @IBOutlet var btn_next: UIButton!
    
    let db = Firestore.firestore()
    var users = [User]()
    
    static var user_names: [String] = []
    static var users_id: [String] = []
    
    static var user_name: String = ""
    static var user_id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextView.delegate = self
        myTextField.delegate = self
        
    }
    
    override func viewWillLayoutSubviews() {
        btn_next.layer.cornerRadius = btn_next.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(setReceiver), name: Notification.Name("SendChallenge_VC1_setReceiver"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("SendChallenge_VC1_setReceiver"), object: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        SendChallenge_VC1.user_names.removeAll()
        SendChallenge_VC1.users_id.removeAll()
        
        if myTextField.text != "" {
            db.collection("users").getDocuments { (querySnapshot, error) in
                guard let querySnapshot = querySnapshot else{
                    return
                }
                self.users = querySnapshot.documents.map {
                    User(dic: $0.data())
                }
                
                for user in self.users {
//                    print("user: \(user)")
                    if user.userName.range(of: self.myTextField.text!) != nil {
                        SendChallenge_VC1.user_names.append(user.userName)
                        SendChallenge_VC1.users_id.append(user.user)
                    } else {
                        print("Error! user.userName: \(user.userName), self.myTextField.text: \(self.myTextField.text!)")
                    }
                }
                
                if SendChallenge_VC1.user_names != [], SendChallenge_VC1.users_id != [] {
                    self.myContantView.isHidden = false
                    NotificationCenter.default.post(name: Notification.Name("showInsertNameTV"), object: nil)
                }
            }
        } else {
            self.myContantView.isHidden = true
            SendChallenge_VC1.user_names.removeAll()
            SendChallenge_VC1.users_id.removeAll()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.myTextField.endEditing(true)
        
        if myTextField.text == "" {
            self.myContantView.isHidden = true
            SendChallenge_VC1.user_names.removeAll()
            SendChallenge_VC1.users_id.removeAll()
        }
        
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.myTextField.endEditing(true)
        self.myTextView.endEditing(true)
    }
    
    @objc func setReceiver() {
        self.myTextField.text = SendChallenge_VC1.user_name
        self.myTextField.endEditing(true)
        self.myContantView.isHidden = true
    }
    
    @IBAction func click_next(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SendChallenge_VC2") as! SendChallenge_VC2
        controller.initiator_name = Global.userName
        controller.initiator = Global.user
        controller.initiateDetail = self.myTextView.text
        controller.receiver = SendChallenge_VC1.user_id
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
