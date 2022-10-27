//
//  TransactionListView.swift
//  Expense Tracker
//
//  Created by Azizbek Asadov on 27/10/22.
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(Array(transactionListVM.groupTransaction()), id: \.key) { (month, transactions) in
                    Section {
                        ForEach(transactions) {
                            TransactionRowView(transaction: $0)
                        }
                    } header: {
                       Text(month)
                    }
                }
            }
            .listStyle(.plain)
            .listSectionSeparator(.hidden)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionListView_Preview: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = transactionListPreviewData
        return vm
    }()
    
    static var previews: some View {
        Group {
            NavigationView {
                TransactionListView()
            }
            NavigationView {
                TransactionListView()
                    .preferredColorScheme(.dark)
            }
        }
        .environmentObject(transactionListVM)
    }
}
