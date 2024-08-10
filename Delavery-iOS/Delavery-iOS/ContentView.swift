//
//  ContentView.swift
//  Delavery-iOS
//
//  Created by Inho Choi on 8/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .sheet(isPresented: .constant(true), content: {
            AppPickerView()
        })
    }
}

#Preview {
    ContentView()
}
