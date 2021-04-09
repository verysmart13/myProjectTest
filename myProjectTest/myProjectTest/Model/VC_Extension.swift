//
//  VC_Extension.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/7.
//

import Foundation
import UIKit

class Select_VC: UIViewController, UINavigationControllerDelegate {
    
    var dismissBtn = UIButton(type: .contactAdd)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismiss_btn()
    }
    
    func dismiss_btn() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_dismiss"), style: .plain, target: self, action: #selector(nav_dismiss))
        self.navigationItem.rightBarButtonItem?.tintColor = .systemGray
    }
    
    @objc func nav_dismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

class Select_3_TV: UITableViewController, UINavigationControllerDelegate {
    
    var dismissBtn = UIButton(type: .contactAdd)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismiss_btn()
    }
    
    func dismiss_btn() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_dismiss"), style: .plain, target: self, action: #selector(nav_dismiss))
        self.navigationItem.rightBarButtonItem?.tintColor = .systemGray
    }
    
    @objc func nav_dismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension UIView{

    func showToast(text: String){
        
        self.hideToast()
        let toastLb = UILabel()
        toastLb.numberOfLines = 0
        toastLb.lineBreakMode = .byWordWrapping
        toastLb.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLb.textColor = UIColor.white
        toastLb.layer.cornerRadius = 10.0
        toastLb.textAlignment = .center
        toastLb.font = UIFont.systemFont(ofSize: 15.0)
        toastLb.text = text
        toastLb.layer.masksToBounds = true
        toastLb.tag = 9999//tag：hideToast實用來判斷要remove哪個label
        
        let maxSize = CGSize(width: self.bounds.width - 40, height: self.bounds.height)
        var expectedSize = toastLb.sizeThatFits(maxSize)
        var lbWidth = maxSize.width
        var lbHeight = maxSize.height
        if maxSize.width >= expectedSize.width{
            lbWidth = expectedSize.width
        }
        if maxSize.height >= expectedSize.height{
            lbHeight = expectedSize.height
        }
        expectedSize = CGSize(width: lbWidth, height: lbHeight)
        toastLb.frame = CGRect(x: ((self.bounds.size.width)/2) - ((expectedSize.width + 20)/2), y: self.bounds.height - expectedSize.height - 40 - 20, width: expectedSize.width + 20, height: expectedSize.height + 20)
        self.addSubview(toastLb)
        
        UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
            toastLb.alpha = 0.0
        }) { (complete) in
            toastLb.removeFromSuperview()
        }
    }
    
    func hideToast(){
        for view in self.subviews{
            if view is UILabel , view.tag == 9999{
                view.removeFromSuperview()
            }
        }
    }
}
