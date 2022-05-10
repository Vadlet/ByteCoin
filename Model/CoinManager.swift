//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate: AnyObject {
    func didUpdatePrice(price: String, curency: String)
    func didFailWithError(error: Error)
}

class CoinManager {
    
    weak var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "E97D37C1-E868-42B0-90E6-319552C97641"
    let currencyArray = [
        "AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY",
        "MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"
    ]
    
    func getCoinPrice(for currency: String) {
        
        let courseRequest = baseURL + currency + "/?apikey=" + apiKey
        
        guard let url = URL(string: courseRequest) else { return }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let bitcoinData = try JSONDecoder().decode(BitcoinData.self, from: data)
                let priceString = String(format: "%.2f", bitcoinData.rate)
                self.delegate?.didUpdatePrice(price: priceString, curency: currency)
            } catch {
                self.delegate?.didFailWithError(error: error)
                return
            }
        } .resume()
    }
}
