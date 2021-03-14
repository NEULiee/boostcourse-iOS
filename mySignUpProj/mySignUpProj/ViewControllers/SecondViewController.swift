//
//  SecondViewController.swift
//  mySignUpProj
//
//  Created by Ha Neul Iee on 2021/03/07.
//

import UIKit

class SecondViewController: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK:- Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    var chooseImage: Bool = false
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNextDisabled()
        
        let tapImageViewGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.presentImagePicker(_:)))
        self.imageView.addGestureRecognizer(tapImageViewGesture)
        imageView.isUserInteractionEnabled = true
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Methods
    func setNextDisabled() {
        nextButton.isEnabled = false
    }
    
    func insertUserInformation() {
        UserInformation.shared.insertInformation(id: idTextField.text!, password: passwordTextField.text!, textView: introduceTextView.text!)
    }
    
    func checkCondition() -> Bool {
        return self.idTextField.text != "" && self.passwordTextField.text != "" && self.checkPasswordTextField.text != "" && self.introduceTextView.text != "" && chooseImage
    }
    
    // MARK: IBAction
    @IBAction func touchUpCancel(_ sender: UIButton!) {
        UserInformation.shared.deleteInformation()
        self.dismiss(animated: true, completion: nil)
    }

    @objc func presentImagePicker(_ gesture: UITapGestureRecognizer) {
        let imagePicker: UIImagePickerController = {
            let picker: UIImagePickerController = UIImagePickerController()
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            return picker
        }()
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        if  checkCondition() {
            if self.passwordTextField.text == self.checkPasswordTextField.text {
                nextButton.isEnabled = true
                insertUserInformation()
            }
        }
        else {
            nextButton.isEnabled = false
        }
        
        return true
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = editedImage
            chooseImage = true
        }
        self.dismiss(animated: true, completion: nil)
    }
}
