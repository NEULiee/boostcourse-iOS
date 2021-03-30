//
//  ThirdViewController.swift
//  MyWeatherTodayProj
//
//  Created by Ha Neul Iee on 2021/03/19.
//

import UIKit

class ThirdViewController: UIViewController {
    
    //MARK:- Properties
    @IBOutlet weak var wetherImage: UIImageView!
    @IBOutlet weak var wetherName: UILabel!
    @IBOutlet weak var temperatures: UILabel!
    @IBOutlet weak var rainProbability: UILabel!
    var cityName: String!
    var weatherState: String!
    var temperaturesText: String!
    var rainProbabilityText: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = cityName
        
        self.wetherImage.image = UIImage(named: weatherState)
        switch self.weatherState {
        case "sunny":
            self.wetherName.text = "맑음"
        case "cloudy":
            self.wetherName.text = "흐림"
        case "rainy":
            self.wetherName.text = "비"
        case "snowy":
            self.wetherName.text = "눈"
        default:
            self.wetherName.text = ""
        }
        self.temperatures.text = self.temperaturesText
        self.rainProbability.text = self.rainProbabilityText

        // Do any additional setup after loading the view.
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
