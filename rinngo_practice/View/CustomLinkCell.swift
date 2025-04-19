//
//  CustomCell.swift
//  rinngo_practice
//
//  Created by 齋藤祐希 on 2025/04/19.
//

import SwiftUI

struct CustomLinkCell: View {
    var label: String
    var value: String
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Button(value) {
                openURL(URL(string: value)!)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    CustomLinkCell(label: "test", value: "test value")
}
