//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Karnav Raval on 2021-05-27.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.headline)
            .fontWeight(.bold)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "Button one")
                .foregroundColor(.white)
            CapsuleText(text: "Button two")
                .foregroundColor(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
