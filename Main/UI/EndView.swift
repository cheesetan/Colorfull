//
//  EndView.swift
//
//
//  Created by Tristan Chay on 25/2/24.
//

import SwiftUI

struct EndView: View {
    var body: some View {
        VStack {
            
            Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .cornerRadius(16)
                .padding(.bottom)
            
            Text("Congrats on making it to the end of Colorfull! I hope that you've managed to learn a thing or two while having fun using this app. Let's work towards a more open and inclusive future for everyone!")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

#Preview {
    EndView()
}
