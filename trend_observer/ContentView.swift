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
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "square.stack.3d.up")
                    Text("History")
                }
        }
    }
}

struct SearchView: View {
    @State private var stock: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a Stock", text: $stock)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                
                NavigationLink(destination: DetailView()) {
                    Text("Check Price")
                        .font(.headline)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Trend Observer")
        }
    }
}

struct DetailView: View {
    var body: some View {
        VStack {
            Text("Stock Price History")
                .font(.largeTitle)
                .padding()
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
