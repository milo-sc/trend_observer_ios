//
//  Model.swift
//  trend_observer
//
//  Created by Victor Wu on 6/14/24.
//

import Foundation

struct Stock: Codable {
    let symbol: String
    let name: String
    let price: Double
}
