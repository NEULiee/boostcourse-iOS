//
//  SecondViewController.swift
//  ViewTransition
//
//  Created by Ha Neul Iee on 2021/02/05.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameLabel.text = UserInformation.shared.name
        self.ageLabel.text = UserInformation.shared.age
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
