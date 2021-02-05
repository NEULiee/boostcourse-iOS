//
//  SecondViewController.swift
//  ViewTransition
//
//  Created by Ha Neul Iee on 2021/02/05.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func popToOver() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dimissModal() {
        self.dismiss(animated: true, completion: nil)
    }
}
