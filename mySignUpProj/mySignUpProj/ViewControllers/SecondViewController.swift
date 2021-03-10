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
    
    // MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNextDisabled()

        let tapImageViewGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.presentImagePicker(_:)))
        // tapImageViewGesture.delegate = self
        self.imageView.addGestureRecognizer(tapImageViewGesture)
        imageView.isUserInteractionEnabled = true
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    func setNextDisabled() {
        nextButton.isEnabled = false
    }
    
    func inputUserInformation() {
        UserInformation.shared.id = idTextField.text
        UserInformation.shared.password = passwordTextField.text
        UserInformation.shared.checkPassword = checkPasswordTextField.text
        UserInformation.shared.textView = introduceTextView.text
    }
    
    // MARK: IBAction
    @IBAction func touchUpCancel(_ sender: UIButton!) {
        UserInformation.shared.deleteInformation()
        self.dismiss(animated: true, completion: nil)
    }

    // tap gesture를 imagePicker에 추가하는 방법
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
    // If all information writed, enable next button
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        inputUserInformation()
        if ((UserInformation.shared.id?.isEmpty) == false) && ((UserInformation.shared.password?.isEmpty) == false) && ((UserInformation.shared.checkPassword?.isEmpty) == false) && ((UserInformation.shared.textView?.isEmpty) == false && chooseImage) {
            if (UserInformation.shared.password == UserInformation.shared.checkPassword) {
                nextButton.isEnabled = true
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
        /*
        else if let cropImage: UIImage = info[UIImagePickerController.InfoKey.cropRect] as? UIImage {
            self.imageView.image = cropImage
        }
        */
        /*
        else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = possibleImage // 원본 이미지가 있을 경우
        }
        */
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
