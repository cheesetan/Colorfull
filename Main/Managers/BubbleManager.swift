//
//  BubbleManager.swift
//  Colorfull
//
//  Created by Tristan Chay on 3/2/24.
//

import SwiftUI

class BubbleManager: ObservableObject {
    static let shared: BubbleManager = .init()
    
    @Published var bubbles: [Bubble] = []
    
    func generateBubbles() {
        for _ in 0..<50 {
            let bubble = Bubble(
                size: CGFloat.random(in: 10...50),
                position: CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                  y: CGFloat.random(in: 0...UIScreen.main.bounds.height)),
                color: Color(hue: Double.random(in: 0...1), saturation: 0.8, brightness: 0.8),
                blurRadius: CGFloat.random(in: 5...15),
                animationDuration: Double.random(in: 7.5...20)
            )
            bubbles.append(bubble)
        }
        
        let redBubble = Bubble(
            id: "redBubble",
            size: CGFloat(64),
            position: CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                              y: CGFloat.random(in: 0...UIScreen.main.bounds.height)),
            color: Color(red: 1, green: 0, blue: 0),
            blurRadius: CGFloat.random(in: 5...15),
            animationDuration: Double.random(in: 7.5...20)
        )
        bubbles.append(redBubble)
        
        let greenBubble = Bubble(
            id: "greenBubble",
            size: CGFloat(64),
            position: CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                              y: CGFloat.random(in: 0...UIScreen.main.bounds.height)),
            color: Color(red: 0, green: 1, blue: 0),
            blurRadius: CGFloat.random(in: 5...15),
            animationDuration: Double.random(in: 7.5...20)
        )
        bubbles.append(greenBubble)
        
        let blueBubble = Bubble(
            id: "blueBubble",
            size: CGFloat(64),
            position: CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                              y: CGFloat.random(in: 0...UIScreen.main.bounds.height)),
            color: Color(red: 0, green: 0, blue: 1),
            blurRadius: CGFloat.random(in: 5...15),
            animationDuration: Double.random(in: 7.5...20)
        )
        bubbles.append(blueBubble)
        
        let whiteCircle = Bubble(
            id: "whiteCircle",
            size: CGFloat(8),
            position: CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                              y: CGFloat.random(in: 0...UIScreen.main.bounds.height)),
            color: Color(.white),
            blurRadius: CGFloat.random(in: 5...15),
            animationDuration: Double.random(in: 7.5...20)
        )
        
        bubbles.append(whiteCircle)
    }
    
    func moveBubble(index: Int) {
        withAnimation(Animation.linear(duration: bubbles[index].animationDuration).repeatForever(autoreverses: true)) {
            let xOffset = CGFloat.random(in: -50...50)
            let yOffset = CGFloat.random(in: -50...50)
            self.bubbles[index].position = CGPoint(x: self.bubbles[index].position.x + xOffset,
                                                   y: self.bubbles[index].position.y + yOffset)
        }
    }
}
