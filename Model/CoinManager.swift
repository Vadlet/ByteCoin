//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "E97D37C1-E868-42B0-90E6-319552C97641"
    let currencyArray = [
        "AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY",
        "MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"
    ]
    
    func getCoinPrice(for currency: String) {
        let courseRequest = baseURL + currency + "/?apikey=" + apiKey
        performRequest(with: courseRequest)
    }
    
    
    func performRequest(with baseURL: String) {
        guard let url = URL(string: baseURL) else { return }
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
//            let jsonString = String(data: data, encoding: .utf8)
//           print(jsonString)
            do {
                let bitcoinData = try JSONDecoder().decode(BitcoinData.self, from: data)
                print(bitcoinData.rate)
            } catch {
                print(error)
            }
            

        } .resume()
    }
}
