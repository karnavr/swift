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


struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}


struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            
            Text("Title template")
                .titleStyle()
            
            
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
