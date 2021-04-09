//
//  LoginVC.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/7.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    
    @IBOutlet var waringLabel: UILabel!
    
    @IBOutlet var btn_signIn: UIButton!
    @IBOutlet var btn_signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        pwTextField.delegate = self
    
    }
    
    override func viewWillLayoutSubviews() {
        btn_signIn.layer.cornerRadius = btn_signIn.frame.height / 2
        btn_signUp.layer.cornerRadius = btn_signUp.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        pwTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signInBT(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: pwTextField.text ?? "") { authResult, error in
            print("authResult: \(String(describing: authResult)), error: \(String(describing: error))")
            if error == nil {
                Global.userEmail = self.emailTextField.text
                self.waringLabel.isHidden = true
                self.performSegue(withIdentifier: "Sign in -> success", sender: nil)
            } else {
                self.waringLabel.isHidden = false
            }
        }
    }
    
    @IBAction func signUpBT(_ sender: Any) {
    }
}
