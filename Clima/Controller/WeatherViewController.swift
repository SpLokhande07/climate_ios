//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController : UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        weatherManager.weatherDelegate = self
        searchTextfield.delegate = self;
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextfield.endEditing(true)
        print(searchTextfield.text!);
        
    }
}


extension UIImageView{
    func load(url:String){
        print("ImageUrl : \(url)");
         let imageURL = URL(string:"https://openweathermap.org/img/wn/\(url)@2x.png")
            print("ImageUrl : \(imageURL)");
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: imageURL!){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                
            }
        }}
    }
}

extension WeatherViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextfield.endEditing(true)
        print(searchTextfield.text!);
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text != ""){
            return true;
        }else{
            textField.placeholder = "Type something here..."
            return false;
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if searchTextfield.text != nil{
            weatherManager.featchWeather(lat: 19.2176466, lon: 73.1328863)
        }
        searchTextfield.text = ""
    }
}

extension WeatherViewController : WeatherManagerDelegate{
    func didUpdateWidget(weather: WeatherModel) {
        print(weather.current.weather)
            DispatchQueue.main.async {
                self.temperatureLabel.text = weather.current.temperatureString
             self.conditionImageView.load(url: weather.current.weather[0].icon)
            }
         }
    
    
    func didFailedWithError(error: Error) {
        print(error)
    }
}

extension WeatherViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("error:: \(error.localizedDescription)")
       }

       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .authorizedWhenInUse {
               locationManager.requestLocation()
           }
       }

       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

           if locations.first != nil {
               print("location:: \(String(describing: locations.first?.coordinate.latitude))")
               weatherManager.featchWeatherUsingLatLong(location: locations.first!)
              
           }

       }

    
}
