//
//  SecondViewController.swift
//  mySignUpProj
//
//  Created by Ha Neul Iee on 2021/03/07.
//

import UIKit

class SecondViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK:- Properties
    // Image view : 이미지는 원래의 비율
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.textContentType = .newPassword
        passwordTextField.isSecureTextEntry = true
        
        setNextDisabled()
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
    // 사용자가 모든 정보를 기입한 상태가 아니라면 화면 오른쪽 하단의 '다음' 버튼은 기본적으로 비활성화되어있으며, 프로필 이미지, 아이디, 자기소개가 모두 채워지고, 패스워드가 일치하면 '다음' 버튼이 활성화됩니다.
    @IBAction func touchUpCancel(_ sender: UIButton!) {
        // 모든 정보가 지워지고 이전 화면1로 되돌아갑니다.
    }

    // MARK: UIGestureRecognizerDelegate
    // If all information writed, enable next button
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        inputUserInformation()
        // 이미지도 추가
        if ((UserInformation.shared.id?.isEmpty) == false) && ((UserInformation.shared.password?.isEmpty) == false) && ((UserInformation.shared.checkPassword?.isEmpty) == false) && ((UserInformation.shared.textView?.isEmpty) == false) {
            if (UserInformation.shared.password == UserInformation.shared.checkPassword) {
                nextButton.isEnabled = true
            }
        }
        else {
            nextButton.isEnabled = false
        }
        return true
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
