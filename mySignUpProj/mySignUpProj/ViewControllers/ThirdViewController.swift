//
//  ThirdViewController.swift
//  mySignUpProj
//
//  Created by Ha Neul Iee on 2021/03/07.
//

import UIKit

class ThirdViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var beforeButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    var dateChanged = false
    
    let dateFormatter: DateFormatter = {
        let format: DateFormatter = DateFormatter()
        format.dateStyle = .long
        return format
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSignInDisabled()
        self.birthdayLabel.text = dateFormatter.string(from: Date())
    }
    
    // MARK:- Methods
    func setSignInDisabled() {
        self.signInButton.isEnabled = false
    }
    
    // MARK: IBAction
    @IBAction func phoneNumberEditingChanged(_ sender: UITextField) {
        if self.phoneNumberTextField.text != "" && dateChanged == true {
            self.signInButton.isEnabled = true
        }
        else {
            self.signInButton.isEnabled = false
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateString: String = dateFormatter.string(from: sender.date)
        self.birthdayLabel.text = dateString
        self.dateChanged = true
        if self.phoneNumberTextField.text != "" && dateChanged == true {
            self.signInButton.isEnabled = true
        }
        else {
            self.signInButton.isEnabled = false
        }
    }
    
    @IBAction func touchUpCancel(_ sender: UIButton!) {
        UserInformation.shared.deleteInformation()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpBefore(_ sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpSignIn(_ sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
}
