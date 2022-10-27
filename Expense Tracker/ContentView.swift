//
//  ContentView.swift
//  Expense Tracker
//
//  Created by Azizbek Asadov on 27/10/22.
//

import SwiftUI
import CoreData
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListsVM: TransactionListViewModel
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24.0) {
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.text)
                    // LineChart
                    
                    let data = transactionListsVM.accumulateTransaction()
                    
                    if !data.isEmpty {
                        let totalExpenses = (data.last?.1 ?? 0.0).formatted(.currency(code: "USD"))
                        CardView {
                            VStack(alignment: .leading) {
                                ChartLabel(totalExpenses, type: .title, format: "$%.02F")
                                LineChart()
                            }
                            .background(Color.systemBackground)
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: [ColorGradient(Color.icon.opacity(0.4), Color.icon)]))
                        .frame(height: 300)
                    }
                    
                    RecentTransactionsList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .foregroundColor(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
            .accentColor(Color.icon)
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }

}

struct ContentView_Previews: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = transactionListPreviewData
        return vm
    }()
    
    static var previews: some View {
        Group {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
