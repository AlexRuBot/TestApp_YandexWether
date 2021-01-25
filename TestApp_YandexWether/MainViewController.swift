//
//  MainViewController.swift
//  TestApp_YandexWether
//
//  Created by Саша Гужавин on 25.01.2021.
//

import UIKit
import MapKit
import Alamofire

class MainViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var newCityTextField: UITextField?
    var wether: [WetherJSON] = []
    var citys: [City] = [City(city: "Калуга", lat: 54.5204, lon: 36.27),
                         City(city: "Самара", lat: 53.2001, lon: 50.15),
                         City(city: "Омск", lat: 54.9924, lon: 73.3686),
                         City(city: "Тула", lat: 54.1961, lon: 37.6182),
                         City(city: "Брянск", lat: 53.2521, lon: 34.3717),
                         City(city: "Казань", lat: 55.7887, lon: 49.1221),
                         City(city: "Пермь", lat: 58.0105, lon: 56.2502),
                         City(city: "Киров", lat: 58.5966, lon: 49.6601),
                         City(city: "Рязань", lat: 54.6269, lon: 39.6916),
                         City(city: "Москва", lat: 55.7522, lon: 37.6156)]
    var filterCitys: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterCitys = citys
        
        addWether(cityArray: citys)
    }

    func addWether(cityArray:[City]) {
        for item in 0...cityArray.count - 1 {
            let URL = "https://api.weather.yandex.ru/v2/forecast?lat=\(cityArray[item].lat)&lon=\(cityArray[item].lon)"

            AF.request(URL, method: .get, encoding: JSONEncoding.default,
                       headers: ["X-Yandex-API-Key": "aab0a824-ac3e-4a37-8f27-2d2e149ba7a0"]).validate().responseJSON { (dataResponse) in
                        guard let data = dataResponse.data else { return }
                        do {
                            let param:WetherJSON = try JSONDecoder().decode(WetherJSON.self, from: data)
                            self.wether.append(param)
                            self.tableView.reloadData()
                        } catch let error {
                            print(error)
                        }
                       }
        }
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wether.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = wether[indexPath.row].geoObject.locality.name
        cell.detailTextLabel?.text = "Температура: \(wether[indexPath.row].fact.temp)"
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let infoVC = segue.destination as! InfoViewController
            infoVC.title = wether[indexPath.row].geoObject.locality.name
            infoVC.info = wether[indexPath.row]
        }
    }
    
    // MARK: - Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        filterCitys = []
        wether = []
        
        if searchText == "" {
            filterCitys = citys
        } else {
            for city in citys {
                if city.city.contains(searchText) {
                    filterCitys.append(city)
                }
            }
        }
        if filterCitys.count == 0 { return } else { addWether(cityArray: filterCitys) }
    }

    @IBAction func addCity(_ sender: Any) {
        
        let alert = UIAlertController(title: "Добавте город", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: newCityTextField)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: okTap)
        let cancleAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancleAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func newCityTextField(textField: UITextField!) {
        newCityTextField = textField
        newCityTextField?.placeholder = "Введите название города"
    }

    func okTap(alertAction: UIAlertAction) {
        
        guard let newCity = newCityTextField?.text else { return }
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(newCity) { (placemarks, error) in
            guard let placemarks = placemarks?.first,
                  let lat = placemarks.location?.coordinate.latitude,
                  let lon = placemarks.location?.coordinate.longitude else { return }
            
            self.citys.append(City(city: newCity, lat: lat, lon: lon))
            self.wether = []
            self.addWether(cityArray: self.citys)
            
            
        }
    }
}

