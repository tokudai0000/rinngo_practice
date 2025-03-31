//
//  ContentView.swift
//  rinngo_practice
//
//  Created by 齋藤祐希 on 2025/03/30.
//

import SwiftUI

struct ContentView: View {
    @State var count: Int = 0
    @State var textColor: Color = .black
    var body: some View {
        VStack {
            Text(String(count))
                .font(.largeTitle)
                .fontWeight(.regular)
                .foregroundColor(textColor)
            HStack {
                Button("Reset") {
                    count = 0
                    
                    textColor = .black
                }

                Button("Tap") {
                    count += 1
                    
                    if (count % 3 == 0) {
                        textColor = .red
                    } else {
                        textColor = .black
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
