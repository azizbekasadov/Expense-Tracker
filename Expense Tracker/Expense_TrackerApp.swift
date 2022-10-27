//
//  Expense_TrackerApp.swift
//  Expense Tracker
//
//  Created by Azizbek Asadov on 27/10/22.
//

import SwiftUI

@main
struct Expense_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
