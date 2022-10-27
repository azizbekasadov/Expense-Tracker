//
//  RecentTransactionsList.swift
//  Expense Tracker
//
//  Created by Azizbek Asadov on 27/10/22.
//

import SwiftUI

struct RecentTransactionsList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack {
            HStack {
                // Header
                Text("Recent Transactions")
                    .bold()
                Spacer()
                
                NavigationLink {
                    TransactionListView()
                } label: {
                    HStack(spacing: 4) {
                        Text("See all")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                    
                }
            }
            .padding(.top)
            
            // List of transactions
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id: \.element) { (index, transaction) in
                TransactionRowView(transaction: transaction)
                Divider().opacity(
                    index == 4 ? 0 : 0.5
                )
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.15), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionsList_Preview: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = transactionListPreviewData
        return vm
    }()
    
    static var previews: some View {
        Group {
            NavigationView {
                RecentTransactionsList()
            }
            NavigationView {
                RecentTransactionsList()
                    .preferredColorScheme(.dark)
            }
        }
        .environmentObject(transactionListVM)
    }
}
