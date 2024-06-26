//
//  ContentView.swift
//  trend_observer
//
//  Created by Victor Wu on 6/7/24.
//

import SwiftUI

var stockName = "<placeholder>"

struct ContentView: View {
    @StateObject private var viewModel = StockViewModel()
    @State private var symbol: String = "AAPL" // Default symbol
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter stock symbol", text: $symbol)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                NavigationLink(destination: DetailView(viewModel: viewModel, symbol: symbol)) {
                    Text("Check Price")
                        .font(.headline)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
//                Button(action: {
//                    viewModel.fetchStock(symbol: symbol)
//                }) {
//                    Text("Fetch Stock")
//                }
//                .padding()
//                
//                if let errorMessage = viewModel.errorMessage {
//                    Text("\(errorMessage)")
//                        .foregroundColor(.red)
//                } else if let stock = viewModel.stock {
//                    Text("\(stock.symbol)")
//                    Text("\(stock.name)")
//                    Text("\(stock.price)")
//                } else {
//                    Text("Enter a stock symbol to fetch data")
//                }
            }
            .padding()
        }
    }
}
//    var body: some View {
//        TabView {
//            SearchView()
//                .tabItem {
//                    Image(systemName: "magnifyingglass")
//                    Text("Search")
//                }
//            
//            HistoryView()
//                .tabItem {
//                    Image(systemName: "square.stack.3d.up")
//                    Text("History")
//                }
//        }
//    }
//struct SearchView: View {
//    @State private var stock: String = ""
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Enter a Stock", text: $stock)
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(5.0)
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, 20)
//                
//                NavigationLink(destination: DetailView()) {
//                    Text("Check Price")
//                        .font(.headline)
//                        .padding()
//                        .background(Color.black)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding()
//            }
//            .navigationTitle("Trend Observer")
//        }
//    }
//}

struct DetailView: View {
    var viewModel: StockViewModel
    var symbol: String
    
    var body: some View {
        VStack {
            Text("Stock Price History")
                .font(.largeTitle)
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
        .navigationTitle(stockName)
    }
}

struct HistoryView: View {
    var body: some View {
        VStack {
            Text("Search History")
                .font(.largeTitle)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
