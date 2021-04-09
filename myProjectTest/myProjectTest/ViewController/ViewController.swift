//
//  ViewController.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/3.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!

    let db = Firestore.firestore()
    var users = [User]()
    
    @IBOutlet var btn_select1: UIButton!
    @IBOutlet var btn_select2: UIButton!
    @IBOutlet var btn_select3: UIButton!
    @IBOutlet var btn_logout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
    }
    
    override func viewWillLayoutSubviews() {
        btn_select1.layer.cornerRadius = btn_select1.frame.height / 2
        btn_select2.layer.cornerRadius = btn_select2.frame.height / 2
        btn_select3.layer.cornerRadius = btn_select3.frame.height / 2
        btn_logout.layer.cornerRadius = btn_logout.frame.height / 2
    }

    @IBAction func click_logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.view.showToast(text: "已登出")
            self.dismiss(animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    func getUserInfo() {
        db.collection("users").whereField("userEmail", isEqualTo: Global.userEmail!).limit(to: 1).getDocuments { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else{
                return
            }
            for document in querySnapshot.documents{
                print(document.documentID)
                print(document.data())
            }
            self.users = querySnapshot.documents.map {
                User(dic: $0.data())
            }
            
            Global.user = self.users[0].user
            Global.userName = self.users[0].userName
            Global.userPost = self.users[0].userPost
            
            self.titleLabel.text = "Hello " + Global.userName! + "!"
        }
    }
}

