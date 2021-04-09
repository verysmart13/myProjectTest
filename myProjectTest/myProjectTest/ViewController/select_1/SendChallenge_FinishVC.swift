//
//  SendChallenge_FinishVC.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/9.
//

import UIKit

class SendChallenge_FinishVC: Select_VC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sleep(2)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
