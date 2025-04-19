//
//  CustomCell.swift
//  rinngo_practice
//
//  Created by 齋藤祐希 on 2025/04/19.
//

import SwiftUI

struct CustomCell: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    CustomCell(label: "test", value: "test value")
}
