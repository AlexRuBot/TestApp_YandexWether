//
//  InfoViewController.swift
//  TestApp_YandexWether
//
//  Created by Саша Гужавин on 26.01.2021.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var feelsLikeLable: UILabel!
    @IBOutlet weak var conditionLable: UILabel!
    @IBOutlet weak var windSpeedLable: UILabel!
    @IBOutlet weak var windDirLable: UILabel!
    @IBOutlet weak var pressureLable: UILabel!
    
    var info: WetherJSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addInfo()
    }

    func addInfo() {
        
        tempLable.text = "Температура: \(info.fact.temp)C"
        feelsLikeLable.text = "По ощущениям: \(info.fact.feelsLike)C"
        windSpeedLable.text = "Скорость ветра: \(info.fact.windSpeed) м/с"
        pressureLable.text = "Давление: \(info.fact.pressure) мм р.с."
        
        switch info.fact.condition {
        case "clear":
            conditionLable.text = "На улице: Ясно"
        case "partly-cloudy":
            conditionLable.text = "На улице: Малооблачно"
        case "cloudy":
            conditionLable.text = "На улице: Облачно с прояснениями"
        case "overcast":
            conditionLable.text = "На улице: Пасмурно"
        case "drizzle":
            conditionLable.text = "На улице: Морось"
        case "light-rain":
            conditionLable.text = "На улице: Небольшой дождь"
        case "rain":
            conditionLable.text = "На улице: Дождь"
        case "moderate-rain":
            conditionLable.text = "На улице: Умеренно сильный дождь"
        case "heavy-rain":
            conditionLable.text = "На улице: Сильный дождь"
        case "continuous-heavy-rain":
            conditionLable.text = "На улице: Длительный сильный дождь"
        case "showers":
            conditionLable.text = "На улице: Ливень"
        case "wet-snow":
            conditionLable.text = "На улице: Дождь со снегом"
        case "light-snow":
            conditionLable.text = "На улице: Небольшой снег"
        case "snow":
            conditionLable.text = "Погодные условия: Снег"
        case "snow-showers":
            conditionLable.text = "Погодные условия: Снегопад"
        case "hail":
            conditionLable.text = "Погодные условия: Град"
        case "thunderstorm":
            conditionLable.text = "Погодные условия: Гроза"
        case "thunderstorm-with-rain":
            conditionLable.text = "Погодные условия: Дождь с грозой"
        case "thunderstorm-with-hail":
            conditionLable.text = "Погодные условия: Гроза с градом"
        default:
            conditionLable.text = "Нет данных"
            
            switch info.fact.windDir {
            case "nw":
                windDirLable.text = "Направление верта: Северо-Западное"
            case "n":
                windDirLable.text = "Направление верта: Северное"
            case "ne":
                windDirLable.text = "Направление верта: Северо-Восточное"
            case "e":
                windDirLable.text = "Направление верта: Восточное"
            case "se":
                windDirLable.text = "Направление верта: Юго-Восточное"
            case "s":
                windDirLable.text = "Направление верта: Южное"
            case "sw":
                windDirLable.text = "Направление верта: Юго-Западное"
            case "w":
                windDirLable.text = "Направление верта: Западное"
            case "c":
                windDirLable.text = "Штиль"
            default:
                windDirLable.text = "Нет данных"
            }
        }
    }
    
}
