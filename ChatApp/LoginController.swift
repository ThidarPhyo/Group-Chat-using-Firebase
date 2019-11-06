//
//  LoginController.swift
//  ChatApp
//
//  Created by Thidar Phyo on 10/17/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "chatRoom", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatRoom" {
            if let dis = segue.destination as? ViewController {
                dis.UserName = userNameTextField.text
            }
        }
    }
    


}
