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
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct HomeView: View {
    @State private var username: String = "<enter your username>"
    @State private var password: String = "<enter your password>"
    
    var body: some View {
        VStack {
            Text("Welcome to Trend Observer")
            
            TextField("Enter stock symbol", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Enter stock symbol", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
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

struct ProfileView: View {
    var body: some View {
        Text("Welcome to Your Profile")
    }
}


#Preview {
    ContentView()
}
