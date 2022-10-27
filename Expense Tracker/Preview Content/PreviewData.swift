//
//  PreviewData.swift
//  Expense Tracker
//
//  Created by Azizbek Asadov on 27/10/22.
//

import Foundation

var transactionPreviewData = Transaction(
    id: 1,
    date: "01/24/2022",
    institution: "Desjarnis",
    account: "Visa *0443",
    merchant: "Apple",
    amount: 799.99,
    type: TransactionType.credit.rawValue,
    categoryId: 801,
    category: "Software",
    isPending: false,
    isTransfer: false,
    isExpense: true,
    isEdited: false
)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
