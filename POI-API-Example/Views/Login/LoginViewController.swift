//
//  LoginViewController.swift
//  POI-API-Example
//
//  Created by Yee Peng Chia on 9/23/17.
//  Copyright © 2017 Keen Code LLC. All rights reserved.
//

import UIKit
import FacebookLogin

protocol LoginViewControllerDelegate: class {    
    func loginViewControllerShouldClose()
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        let closeButton = UIBarButtonItem(title: "Close",
                                          style: .plain,
                                          target: self,
                                          action: #selector(LoginViewController.closeClick))
        navigationItem.leftBarButtonItem = closeButton
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .custom("user_location") ])
        loginButton.center = view.center
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeClick() {
        delegate?.loginViewControllerShouldClose()
    }
    

}
