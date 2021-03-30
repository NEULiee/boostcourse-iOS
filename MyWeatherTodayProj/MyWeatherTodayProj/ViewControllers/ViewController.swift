//
//  ViewController.swift
//  MyWeatherTodayProj
//
//  Created by Ha Neul Iee on 2021/03/19.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    // MARK:- Properties
    @IBOutlet weak var countryTable: UITableView!
    let cellIdentifier: String = "countryCell"
    var countries: [Country] = []
    
    // MARK:- Method
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let country: Country = self.countries[indexPath.row]
        
        cell.imageView?.image = UIImage(named: "flag_" + self.countries[indexPath.row].assetName)
        
        cell.textLabel?.text = country.koreanName
        
        return cell
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "세계 날씨"
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
            print("에러나따")
            return
        }
        
        do {
            self.countries = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            print("에러나따2")
            print(error.localizedDescription)
        }
        
        self.countryTable.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        
        guard let countryCell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        nextViewController.countryName = countryCell.textLabel?.text
        switch countryCell.textLabel?.text {
        case "한국":
            nextViewController.assetName = "kr"
        case "독일":
            nextViewController.assetName = "de"
        case "이탈리아":
            nextViewController.assetName = "it"
        case "미국":
            nextViewController.assetName = "us"
        case "프랑스":
            nextViewController.assetName = "fr"
        case "일본":
            nextViewController.assetName = "jp"
        default:
            return
        }
    }
    
}

