//
//  ImageView.swift
//  rinngo_practice
//
//  Created by 齋藤祐希 on 2025/04/09.
//

import SwiftUI

struct ImageView: View {
    var image: String
    
    var body: some View {
        Image(image)
    }
}

#Preview {
    ImageView(image: "Apple")
}
