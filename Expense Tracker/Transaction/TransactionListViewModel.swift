//
//  TransactionListViewModel.swift
//  Expense Tracker
//
//  Created by Azizbek Asadov on 27/10/22.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)] // cummulative sums

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        let urlString = "https://designcode.io/data/transactions.json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL \(urlString)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    print("No response")
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Success • Finished catching the transactions")
                    
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions)
            }
            .store(in: &cancellables)
    }
    
    enum DateFormat {
        case month
        case day
        case year
    }
    
    func groupTransaction(by dateFormat: DateFormat = .month) -> TransactionGroup {
        guard !transactions.isEmpty else {
            return [:]
        }
        
        return TransactionGroup(grouping: self.transactions) { transaction in
            switch dateFormat {
            case .month:
                return transaction.month
            case .day:
                return transaction.day
            case .year:
                return transaction.year
            }
        }
    }
    
    func accumulateTransaction() -> TransactionPrefixSum {
        print(#function)
        guard !transactions.isEmpty else {
            return []
        }
        
        let today = "02/17/2022".dateParsed()
        guard let dateInterval = Calendar.current.dateInterval(
            of: Calendar.Component.month,
            for: today
        ) else { return [] }
        print(dateInterval)
        
        var sum: Double = 0.0
        var cumSum:TransactionPrefixSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) { // by day
            let dailyExpenses = transactions.filter({ $0.dateParsed == date && $0.isExpense })
            let dailyTotal = dailyExpenses.reduce(0, { $0 - $1.signedAmount })
            
            sum += dailyTotal
            cumSum.append((date.formatted(), sum.roudedTo2Digits()))
            print(date.formatted(), dailyTotal, sum)
        }
        
        return cumSum
    }
}



