//
//  HitbtcRequest.swift
//  HTMLCoin
//
//  Created by Jonathan Goncalves da Silva on 06/10/21.
//

import Foundation

protocol ExchangeService {
    func getData(completion: @escaping (Result<[ExchangeData], Error>) -> Void)
}

enum ExchangeError:Error{
    case defaultError
    case firstError
}

struct HitbtcRequest: ExchangeService {
    func getData(completion: @escaping(Result<[ExchangeData], Error>) -> Void) {
        let url = URL(string: "https://api.hitbtc.com/api/3/public/ticker?symbols=HTMLBTC,HTMLETH,HTMLUSDT")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let jsonData = data else {
                completion(.failure(ExchangeError.firstError))
                return
            }
            
            let ret = try? JSONDecoder().decode(HitbtcResult.self, from: jsonData)
            
            if let result = ret {
                var ed: [ExchangeData] = []
                
                ed.append (
                    ExchangeData (
                        exchange: "Hitbtc",
                        coin: "HTML",
                        market: "BTC",
                        last: result.htmlbtc.last,
                        high: result.htmlbtc.high,
                        low: result.htmlbtc.low,
                        bid: result.htmlbtc.bid,
                        ask: result.htmlbtc.ask,
                        volume: result.htmlbtc.volumeQuote
                    )
                )
                
                
                ed.append (
                    ExchangeData (
                        exchange: "Hitbtc",
                        coin: "HTML",
                        market: "ETH",
                        last: result.htmleth.last,
                        high: result.htmleth.high,
                        low: result.htmleth.low,
                        bid: result.htmleth.bid,
                        ask: result.htmleth.ask,
                        volume: result.htmleth.volumeQuote
                    )
                )
                
                ed.append (
                    ExchangeData (
                        exchange: "Hitbtc",
                        coin: "HTML",
                        market: "USDT",
                        last: result.htmlusdt.last,
                        high: result.htmlusdt.high,
                        low: result.htmlusdt.low,
                        bid: result.htmlusdt.bid,
                        ask: result.htmlusdt.ask,
                        volume: result.htmlusdt.volumeQuote
                    )
                )
                
                completion(.success(ed))
                
                return
            }
            
            completion(.failure(ExchangeError.defaultError))
        }.resume()
    }
}

