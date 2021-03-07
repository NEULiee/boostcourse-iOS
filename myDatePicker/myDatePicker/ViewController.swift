//
//  ViewController.swift
//  myDatePicker
//
//  Created by Ha Neul Iee on 2021/03/05.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        // formatter.dateStyle = .medium
        // formatter.timeStyle = .medium
        return formatter
    }()
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let date: Date = sender.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.dateLabel.text = dateString
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        // self.view.addGestureRecognizer(tapGesture)
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
        self.datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
    }

    // touch 받아도 되나?
    // delegate 사용을 하면 다양한 상황에 맞는 동작들을 제어할 수 있다.
    // target-action: 단순한 상황
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

