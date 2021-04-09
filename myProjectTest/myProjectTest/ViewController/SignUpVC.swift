//
//  SignUpVC.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/10.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class SignUpVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var btn_signUp: UIButton!
    @IBOutlet var btn_cancel: UIButton!
    
    @IBOutlet var user: UITextField!
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var userName: UITextField!
    @IBOutlet var userPost: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user.delegate = self
        userEmail.delegate = self
        password.delegate = self
        userName.delegate = self
        userPost.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        btn_signUp.layer.cornerRadius = btn_signUp.frame.height / 2
        btn_cancel.layer.cornerRadius = btn_cancel.frame.height / 2
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        user.endEditing(true)
        userEmail.endEditing(true)
        password.endEditing(true)
        userName.endEditing(true)
        userPost.endEditing(true)
        
        return true
    }
    
    @IBAction func click_btn(_ sender: Any) {
        if user.text != "", password.text != "", password.text != "", userName.text != "", userPost.text != "" {
            Auth.auth().createUser(withEmail: userEmail.text!, password: password.text!) { (user, error) in
                if error != nil {
                    print(error)
                }
            }
            let userData: [String: Any] = ["user": user.text!, "userEmail": userEmail.text!, "password": password.text!, "userName": userName.text!, "userPost": userPost.text!]
            db.collection("users").addDocument(data: userData)
            
            self.dismiss(animated: true, completion: nil)
        } else {
            self.view.showToast(text: "資料不得空白！")
        }
    }
    
    @IBAction func click_cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
