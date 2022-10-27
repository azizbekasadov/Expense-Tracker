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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
