//
//  BitcoinData.swift
//  ByteCoin
//
//  Created by Vadlet on 06.05.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct BitcoinData: Codable {
    let rate: Rate
}

struct Rate: Codable {
    let rate: Int
}
