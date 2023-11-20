//
//  WeatherProtocol.swift
//  Clima
//
//  Created by Saiprasad lokhande on 18/11/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWidget(weather : WeatherModel)
    func didFailedWithError (error : Error)
}
