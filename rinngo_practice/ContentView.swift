//
//  ContentView.swift
//  rinngo_practice
//
//  Created by 齋藤祐希 on 2025/03/30.
//

import SwiftUI

struct ContentView: View {
    @State var count: Int = 0
    var body: some View {
        VStack {
            Text(String(count))
                .font(.largeTitle)
                .fontWeight(.regular)
            Button("Tap") {
                count += 1
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
