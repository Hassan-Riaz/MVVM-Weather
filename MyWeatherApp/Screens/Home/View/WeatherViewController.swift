
//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Munsif Hayat on 31/01/2022.
//

import UIKit

protocol WeatherViewDelegate {
    func cityChanged(city: CityCellViewModel)
}

class WeatherViewController : UIViewController  {
    
    @IBOutlet var vwSub: UIView!
    @IBOutlet var vwSubFirst: UIView!
    
    lazy var viewModel = {
        WeatherViewModel(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViewModel()
        
    }
    
    
    func initViewModel() {
        viewModel.getWeather(woid: "44418")
    }
    
    // MARK :- Custom Actions
    
    @IBAction func actChangeCity(_ sender: UIButton) {
        
        if let citySelectionVC = Constants.mainStoryboard.instantiateViewController(withIdentifier: Constants.citySelectionVC) as? CitySelectionViewController {
            self.navigationController?.pushViewController(citySelectionVC, animated: false)
        }
    }
}

extension WeatherViewController: WeatherViewDelegate {

    func cityChanged(city: CityCellViewModel) {
        self.viewModel.getWeather(woid: city.woeid)
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    
    func loadData(weather: WeatherDetailsViewModel) {
        
    }
}
