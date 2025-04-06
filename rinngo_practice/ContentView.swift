//
//  ContentView.swift
//  rinngo_practice
//
//  Created by 齋藤祐希 on 2025/03/30.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("CountKey") var count: Int = 0
    @State var textColor: Color = .black
    var body: some View {
        VStack {
            Text(String(count))
                .font(.largeTitle)
                .fontWeight(.regular)
                .foregroundColor(getColor())
            HStack {
                Button("Reset") {
                    count = 0
                }

                Button("Tap") {
                    count += 1
                }
            }
        }
        .padding()
    }
    
    func getColor() -> Color {
        (count % 3 == 0 && count != 0) ? .red : .black
    }
}

#Preview {
    ContentView()
}
