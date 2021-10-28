// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct HitbtcResult: Codable {
    let htmlbtc, htmleth, htmlusdt: HitbtcData
    
    enum CodingKeys: String, CodingKey {
        case htmlbtc = "HTMLBTC"
        case htmleth = "HTMLETH"
        case htmlusdt = "HTMLUSDT"
    }
}

// MARK: - Htmlbtc
struct HitbtcData: Codable {
    let ask, bid, last, low: String
    let high, htmlbtcOpen, volume, volumeQuote: String
    let timestamp: String
    
    enum CodingKeys: String, CodingKey {
        case ask, bid, last, low, high
        case htmlbtcOpen = "open"
        case volume
        case volumeQuote = "volume_quote"
        case timestamp
    }
}
