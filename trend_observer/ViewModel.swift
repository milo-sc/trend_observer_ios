//
//  ViewModel.swift
//  trend_observer
//
//  Created by Victor Wu on 6/14/24.
//

import Foundation
import Combine

class StockViewModel: ObservableObject {
    @Published var stock: Stock?
    @Published var errorMessage: String?
    private var cancellable: AnyCancellable?
    
    func fetchStock(symbol: String) {
        guard let url = URL(string: "https://trend-observer-vyqcemcdzq-ue.a.run.app/stock/\(symbol)") else {
                errorMessage = "Invalid URL"
                return
            }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                        // Throw an error if the response is not valid
                        guard let httpResponse = output.response as? HTTPURLResponse,
                              httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                        return output.data
                    }
            .decode(type: Stock.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        self.errorMessage = nil
                    case .failure(let error):
                        self.handleError(error: error, url: url)
                }
            }, receiveValue: { [weak self] stock in
                self?.stock = stock
                print("Fetched stock: \(stock)")  // Print the stock data to the console
            })
    }
    
    private func handleError(error: Error, url: URL) {
        // Attempt to fetch the raw data to inspect the failure JSON
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                // Try to convert the raw data to a JSON object for inspection
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    DispatchQueue.main.async {
                        self.errorMessage = "\(json)"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "\(error?.localizedDescription ?? "Unknown error")"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "\(error?.localizedDescription ?? "Unknown error")"
                }
            }
        }.resume()
    }
}
