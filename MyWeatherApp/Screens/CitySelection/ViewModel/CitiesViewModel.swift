//
//  CitiesViewModel.swift
//  MyWeatherApp
//
//  Created by Munsif Hayat on 02/02/2022.
//

import Foundation


class CitiesViewModel : NSObject {
    
    var reloadTableView: (() -> Void)?
    
    var cities = [Citylist]()
    
    var cityCellViewModels = [CityCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func fetchData(cities: [Citylist]) {
        self.cities = cities // Cache
        var vms = [CityCellViewModel]()
        for city in cities {
            vms.append(createCellModel(cityDetails:city))
        }
        cityCellViewModels = vms
    }
    
    func createCellModel(cityDetails: Citylist) -> CityCellViewModel {
        let woeid = cityDetails.woeid
        let cityName = cityDetails.cityName
        
        return CityCellViewModel(woeid: woeid, cityName: cityName)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CityCellViewModel {
        return cityCellViewModels[indexPath.row]
    }
    
    
    
    func readLocalJSONFile(forName name: String) -> Data? {
        
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
        
    }
    
    func parse(jsonData: Data) -> cityRecords? {
        do {
            let decodedData = try JSONDecoder().decode(cityRecords.self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    
    func getEmployees() {
        let jsonData = readLocalJSONFile(forName: "CitiesList")
        if let data = jsonData {
            if let cityDetailsData = parse(jsonData: data) {
                //You can read sampleRecordObj just like below.
                print(cityDetailsData)
                self.fetchData(cities: cityDetailsData.cities)
            }
            
        }
    }
}
