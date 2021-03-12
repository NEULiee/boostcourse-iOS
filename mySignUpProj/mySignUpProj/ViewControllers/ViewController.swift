//
//  ViewController.swift
//  mySignUpProj
//
//  Created by Ha Neul Iee on 2021/03/07.
//

import UIKit

class ViewController: UIViewController {
    // MARK:- Properites
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.idTextField.text = UserInformation.shared.id
    }
}

