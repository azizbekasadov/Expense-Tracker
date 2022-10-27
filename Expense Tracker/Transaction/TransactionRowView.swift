//
//  TransactionView.swift
//  Expense Tracker
//
//  Created by Azizbek Asadov on 27/10/22.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRowView: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.icon)
                .opacity(0.3)
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.icon)
                }
            
            VStack(alignment: .leading, spacing: 6.0) {
                Text(transaction.merchant)
                .font(.subheadline)
                .bold()
                .lineLimit(1)
                
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(
                        .secondary)
               
            }
            
            Spacer()
            
            Text(transaction.signedAmount, format: .currency(code: "USD"))
                .foregroundColor(
                    transaction.isExpense ? .red : .green
                )
                .bold()
        }
        .padding([.top, .bottom], 8)
        .padding([.leading, .trailing], 16)
    }
}

struct TransactionRowView_Preview: PreviewProvider {
    static var previews: some View {
        TransactionRowView(transaction: transactionPreviewData)
        
        TransactionRowView(transaction: transactionPreviewData).preferredColorScheme(.dark)
    }
}
