//
//  ContentView.swift
//  HTMLCoinPrice WatchKit Extension
//
//  Created by Jonathan Goncalves da Silva on 25/10/21.
//

import SwiftUI

extension String {
    func rounded() -> String {
        return self
    }
}

struct ContentView: View {
    @State var loading: Bool = false
    @State var exchangesData: [ExchangeData] = []
    
    func loadData() {
        loading = true
        HitbtcRequest().getData { result in
            var data: [ExchangeData] = []
            
            if case .success(let fetchedData) = result {
                data = fetchedData
                
                exchangesData = data
                
                loading = false
            }
        }
    }
    
    func rowCoin(ed: ExchangeData) -> some View {
        VStack {
            Text("HitBTC HTML-\(ed.market)")
            HStack {
                Text("Last")
                Spacer()
                Text("\(ed.last!.rounded())")
            }
            HStack {
                Text("Bid")
                Spacer()
                Text("\(ed.bid!.rounded())")
            }
            HStack {
                Text("Ask")
                Spacer()
                Text("\(ed.ask!.rounded())")
            }
            HStack {
                Text("Vol.")
                Spacer()
                Text("\(String((Double(ed.volume!)! * 10000).rounded()/10000))")
            }
            HStack {
                Text("1M~")
                Spacer()
                Text(String(Double(ed.last!)! * 1000000))
            }
        }
    }
    
    func updateButton() -> some View {
        Button(action: {
            loadData()
        }) {
            Text(loading ? "Updating..." : "Update")
        }
    }
    
    var body: some View {
        Group {
            if loading {
                updateButton()
            } else {
                List {
                    updateButton()
                    
                    ForEach(exchangesData.filter { $0.market.lowercased() == "btc" }) { ed in
                        rowCoin(ed: ed)
                    }
                    
                    ForEach(exchangesData.filter { $0.market.lowercased() != "btc" }) { ed in
                        rowCoin(ed: ed)
                    }
                    
                    updateButton()
                }
            }
        }
        .onAppear {
            loadData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
