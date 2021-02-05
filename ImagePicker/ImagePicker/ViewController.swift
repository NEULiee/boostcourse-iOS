//
//  ViewController.swift
//  ImagePicker
//
//  Created by Ha Neul Iee on 2021/02/05.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        // UIImagePickerControllerDelegate & UINavigationControllerDelegate 의 합성 프로토콜
        picker.delegate = self
        return picker
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func touchUpSelectImageButton(_ sender: UIButton) {
        // imagePicker 을 modal로 올려줍니다.
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate function
    // 취소했을 때 modal을 내려줍니다.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = originalImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    


}

