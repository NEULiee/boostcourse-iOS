//
//  SecondViewController.swift
//  MyWeatherTodayProj
//
//  Created by Ha Neul Iee on 2021/03/19.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource {
    
    // MARK:- Properties
    var countryName: String!
    var assetName: String!
    @IBOutlet weak var cityTable: UITableView!
    let cellIdentifier: String = "cityCell"
    var cities: [City] = []
    
    // MARK:- method
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: customCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? customCell else {
            print("cell type castring failed")
            let emptyCell: UITableViewCell = UITableViewCell()
            return emptyCell
        }
        let city: City = self.cities[indexPath.row]

        cell.cityLabel.text? = city.cityName
        cell.cityLabel.font = .boldSystemFont(ofSize: 16)
        cell.temperaturesLabel.text? = city.temperatures
        cell.rainProbabilityLabel.text? = city.showRainfallProbability
        var wether: UIImage? {
            switch city.state {
            case 10:
                cell.wetherState = "sunny"
                return UIImage(named: "sunny")
            case 11:
                cell.wetherState = "cloudy"
                return UIImage(named: "cloudy")
            case 12:
                cell.wetherState = "rainy"
                return UIImage(named: "rainy")
            case 13:
                cell.wetherState = "snowy"
                return UIImage(named: "snowy")
            default:
                return nil
            }
        }
        cell.weatherImage.image = wether
        
        return cell
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = countryName
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: assetName) else {
            print("오류나따3")
            return
        }
        
        do {
            self.cities = try jsonDecoder.decode([City].self, from: dataAsset.data)
        } catch {
            print("오류나따4")
            print(error.localizedDescription)
        }
        
        self.cityTable.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: ThirdViewController = segue.destination as? ThirdViewController else {
            print("failed")
            return
        }
        
        guard let cell: customCell = sender as? customCell else {
            print("failed")
            return
        }
        
        nextViewController.cityName = cell.cityLabel.text
        nextViewController.weatherState = cell.wetherState
        nextViewController.temperaturesText = cell.temperaturesLabel.text
        nextViewController.rainProbabilityText = cell.rainProbabilityLabel.text
    }

}
