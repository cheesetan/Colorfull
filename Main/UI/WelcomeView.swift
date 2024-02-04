//
//  WelcomeView.swift
//  Colorfull
//
//  Created by Tristan Chay on 3/2/24.
//

import SwiftUI

struct Bubble: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var size: CGFloat
    var position: CGPoint
    var color: Color
    var blurRadius: CGFloat
    var animationDuration: Double
}

struct WelcomeView: View {
    
    @State private var steps = 0
    
    @State var bubbleSize = CGFloat(128)
    @State var rotationAngle: Double = 0
    
    @State var redLocation: CGPoint = CGPoint(x: 0, y: 0)
    @State var greenLocation: CGPoint = CGPoint(x: 0, y: 0)
    @State var blueLocation: CGPoint = CGPoint(x: 0, y: 0)
    
    @GestureState private var redStartLocation: CGPoint? = nil
    @GestureState private var greenStartLocation: CGPoint? = nil
    @GestureState private var blueStartLocation: CGPoint? = nil
    
    @ObservedObject var bubbleManager: BubbleManager = .shared
    
    @Namespace var animation
        
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if steps > 0 {
                    colorTheoryScreen
                } else {
                    startScreen
                }
            }
            .onAppear {
                bubbleManager.generateBubbles()
                
                redLocation = CGPoint(x: (geometry.size.width / 2), y: (geometry.size.height / 2) - (bubbleSize / 2) + 2.5)
                greenLocation = CGPoint(x: (geometry.size.width / 2) - (bubbleSize / 2) - 5, y: (geometry.size.height / 2) + (bubbleSize / 2) - 2.5)
                blueLocation = CGPoint(x: (geometry.size.width / 2) + (bubbleSize / 2) + 5, y: (geometry.size.height / 2) + (bubbleSize / 2) - 2.5)
            }
        }
    }
    
    var startScreen: some View {
        ZStack {
            ForEach(bubbleManager.bubbles) { bubble in
                Circle()
                    .fill(bubble.color)
                    .matchedGeometryEffect(id: bubble.id, in: animation)
                    .frame(width: bubble.size, height: bubble.size)
                    .position(bubble.position)
                    .blur(radius: bubble.blurRadius)
                    .onAppear {
                        withAnimation(Animation.linear(duration: bubble.animationDuration).repeatForever(autoreverses: true)) {
                            bubbleManager.moveBubble(index: bubbleManager.bubbles.firstIndex(of: bubble)!)
                        }
                    }
            }
            
            VStack {
                Text("Colorfull")
                    .font(.system(size: 64))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                Button {
                    withAnimation {
                        if steps < 1 {
                            steps += 1
                        }
                    }
                } label: {
                    Text("START")
                        .padding()
                        .font(.title3)
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(.blue)
                        .cornerRadius(16)
                        .matchedGeometryEffect(id: "button", in: animation)
                }
                .buttonStyle(.plain)
                .padding(.top, -15)
            }
        }
    }
    
    var colorTheoryScreen: some View {
        ZStack {
            let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
            ZStack {
                Circle()
                    .fill(.blue.opacity(0.4))
                    .matchedGeometryEffect(id: "blueBubble", in: animation)
                    .frame(width: bubbleSize, height: bubbleSize)
                    .position(blueLocation)
                    .gesture(dragBlue)
                Circle()
                    .fill(.green.opacity(0.4))
                    .matchedGeometryEffect(id: "greenBubble", in: animation)
                    .frame(width: bubbleSize, height: bubbleSize)
                    .position(greenLocation)
                    .gesture(dragGreen)
                Circle()
                    .fill(.red.opacity(0.4))
                    .matchedGeometryEffect(id: "redBubble", in: animation)
                    .frame(width: bubbleSize, height: bubbleSize)
                    .position(redLocation)
                    .gesture(dragRed)
            }
            .offset(y: -20)
            .rotationEffect(Angle(degrees: rotationAngle))
            .onReceive(timer) { _ in
                withAnimation {
                    if steps < 6 {
                        rotationAngle += 1
                    }
                }
            }
            
            if steps < 6 {
                Circle()
                    .fill(.white)
                    .matchedGeometryEffect(id: "whiteCircle", in: animation)
                    .frame(width: 8, height: 8)
            }
            
            VStack {
                VStack {
                    Spacer()
                    if steps == 1 {
                        Text("Each of our eyes have three types of cones to see colors: short-wavelength cones for blue, medium-wavelength cones for green, and long-wavelength cones for red.")
                    } else if steps == 2 {
                        Text("When light enters our eyes, these cones are activated in different combinations based on the wavelengths of light.")
                    } else if steps == 3 {
                        Text("Our brain then processes these signals to create the perception of various colors.")
                    } else if steps == 4 {
                        Text("By mixing different intensities of red, green, and blue, our eyes can see the full spectrum of colors.")
                    } else if steps == 5 {
                        Text("That's how electronic devices like your iPad display color!")
                    } else if steps == 6 {
                        Text("Try making colors by overlapping the red, green, and blue colored circles!")
                    }
                }
                .font(.title)
                .fontWeight(.heavy)
                .lineLimit(3)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding([.horizontal, .bottom])
                
                Button {
                    if steps < 6 {
                        withAnimation {
                            steps += 1
                            if steps == 6 {
                                bubbleSize = 256
                            }
                        }
                    }
                } label: {
                    Text(steps < 6 ? "NEXT" : "")
                        .padding()
                        .font(.title3)
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(steps < 6 ? .orange : .clear)
                        .cornerRadius(16)
                        .matchedGeometryEffect(id: "button", in: animation)
                }
                .buttonStyle(.plain)
                .padding(.bottom)
            }
        }
    }
    
    var dragRed: some Gesture {
        DragGesture()
            .onChanged { value in
                if steps == 6 {
                    withAnimation {
                        steps += 1
                    }
                }
                var newLocation = redStartLocation ?? redLocation // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                if steps > 5 {
                    redLocation = CGPoint(x: newLocation.x, y: newLocation.y)
                }
            }
            .updating($redStartLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? redLocation
            }
    }
    
    var dragGreen: some Gesture {
        DragGesture()
            .onChanged { value in
                if steps == 6 {
                    withAnimation {
                        steps += 1
                    }
                }
                var newLocation = greenStartLocation ?? greenLocation // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                if steps > 5 {
                    greenLocation = CGPoint(x: newLocation.x, y: newLocation.y)
                }
            }
            .updating($greenStartLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? greenLocation
            }
    }
    
    var dragBlue: some Gesture {
        DragGesture()
            .onChanged { value in
                if steps == 6 {
                    withAnimation {
                        steps += 1
                    }
                }
                var newLocation = blueStartLocation ?? blueLocation // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                if steps > 5 {
                    blueLocation = CGPoint(x: newLocation.x, y: newLocation.y)
                }
            }
            .updating($blueStartLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? blueLocation
            }
    }
}

#Preview {
    WelcomeView()
}
