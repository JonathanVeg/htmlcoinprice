//
//  ExchangeData.swift
//  HTMLCoin
//
//  Created by Jonathan Goncalves da Silva on 07/10/21.
//

import Foundation

struct ExchangeData: Codable, Identifiable {
    var id: Int = Int.random(in: 1..<9999)
    let exchange: String
    let coin, market: String
    let last, high, low: String?
    var open: String? = "1"
    let bid, ask: String?
    
    let volume: String?
    
}
