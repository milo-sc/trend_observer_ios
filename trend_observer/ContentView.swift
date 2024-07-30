//
//  ContentView.swift
//  trend_observer
//
//  Created by Victor Wu on 6/7/24.
//

import SwiftUI

var stockName = "<placeholder>"

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            AlertListView()
                .tabItem {
                    Image(systemName: "square.stack")
                    Text("Alert List")
                }
        }
    }
}

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Trend Observer")
        }
    }
}

struct SearchView: View {
    @StateObject private var viewModel = StockViewModel()
    @State private var symbol: String = "AAPL" //Default symbol
    
    var body: some View {
        VStack {
            TextField("Enter stock symbol", text: $symbol)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                viewModel.fetchStock(symbol: symbol)
            }) {
                Text("Fetch Stock")
            }
            .padding()
            
            if let errorMessage = viewModel.errorMessage {
                Text("\(errorMessage)")
                    .foregroundColor(.red)
            } else if let stock = viewModel.stock {
                Text("\(stock.symbol)")
                Text("\(stock.name)")
                Text("\(stock.price)")
            } else {
                Text("Enter a stock symbol to fetch data")
            }
        }
    }
}

struct AlertListView: View {
    let stocks = [
        Stock(symbol: "AAPL", name: "Apple", price: 111),
        Stock(symbol: "MSFT", name: "Microsoft", price: 111),
        Stock(symbol: "NVDA", name: "NVIDIA", price: 111),
        Stock(symbol: "GOOG", name: "Google", price: 111),
        Stock(symbol: "AMZN", name: "Amazon", price: 111),
    ]

    var body: some View {
        NavigationView {
            List(stocks) { stock in
                HStack {
                    Circle()
                        .frame(width: 20, height: 20)
                    Text(stock.symbol)
                    Text(stock.name)
//                    Text(stock.price)
                }
            }
            .navigationTitle("Stocks")
        }
    }
}

#Preview {
    ContentView()
}
