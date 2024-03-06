//
//  ColorBlindHelpView.swift
//
//
//  Created by Tristan Chay on 25/2/24.
//

import SwiftUI

struct ColorBlindHelpView: View {
    
    @State var steps = 0
    
    @State var bounceEffect = 0
    
    @State var showingSimulationView = false
    
    @State var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                VStack {
                    if steps <= 1 {
                        Image(systemName: "person.crop.circle.badge.questionmark")
                            .resizable()
                            .symbolEffect(.bounce, value: bounceEffect)
                            .scaledToFit()
                            .frame(width: 128)
                    } else if steps == 2 {
                        Image(systemName: "hand.raised.fingers.spread.fill")
                            .resizable()
                            .symbolEffect(.bounce, value: bounceEffect)
                            .scaledToFit()
                            .frame(width: 128)
                    } else if steps == 3 {
                        Image(systemName: "bubble.left.and.text.bubble.right.fill")
                            .resizable()
                            .symbolEffect(.bounce, value: bounceEffect)
                            .scaledToFit()
                            .frame(width: 128)
                    } else if steps == 4 {
                        Image(systemName: "camera.filters")
                            .resizable()
                            .symbolEffect(.bounce, value: bounceEffect)
                            .scaledToFit()
                            .frame(width: 128)
                    } else if steps == 5 {
                        Image(systemName: "gear")
                            .resizable()
                            .symbolEffect(.bounce, value: bounceEffect)
                            .scaledToFit()
                            .frame(width: 128)
                    } else if steps == 6 {
                        Image(systemName: "square.filled.on.square")
                            .resizable()
                            .symbolEffect(.bounce, value: bounceEffect)
                            .scaledToFit()
                            .frame(width: 128)
                    } else if steps == 7 {
                        Image(systemName: "ipad.rear.camera")
                            .resizable()
                            .symbolEffect(.bounce, value: bounceEffect)
                            .scaledToFit()
                            .frame(width: 128)
                    }
                }
                .onReceive(timer) { _ in
                    withAnimation {
                        if steps == 5 {
                            rotationAngle += 1
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    if steps <= 1 {
                        Text("So, how can you help color blind people?")
                    } else if steps == 2 {
                        Text("1a. Be respectful if they tell you they are color blind. Most color blind people tend to keep their color blindness a secret, so be respectful if they tell you about it.")
                    } else if steps == 3 {
                        Text("1b. Dont poke fun of them with questions like \"What color is this?\", they have heard enough of that question before.")
                    } else if steps == 4 {
                        Text("2a. Enable your device's color filter mode to help them view colors accurately on your device. Most operating systems have a color filter mode that adjusts the phone's colors to allow color blind people to view colors accurately.")
                    } else if steps == 5 {
                        Text("2b. On iOS and iPadOS, you can enable this feature by going to Settings > Accessibility > Display & Text Size > Color Filters.")
                    } else if steps == 6 {
                        Text("3. Accomodate to their needs. Dont use colors like red and green to differentiate things for people with deuteranopia or protanopia. Instead, use contrasting colors.")
                    } else if steps == 7 {
                        Text("Let's try simulating what it's like to view your environment as someone with color blindness. Press continue to open the simulator.")
                    }
                }
                .font(.title)
                .fontWeight(.heavy)
                .lineLimit(3)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding([.horizontal, .bottom])
                
                Button {
                    if steps < 7 {
                        withAnimation {
                            steps += 1
                        }
                    } else {
                        showingSimulationView = true
                    }
                } label: {
                    Text(steps == 7 ? "Continue" : "Next")
                        .padding()
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(steps == 7 ? .blue : .orange)
                        .cornerRadius(16)
                }
                .buttonStyle(.plain)
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            steps += 1
        }
        .onChange(of: steps) {
            bounceEffect += 1
        }
        .fullScreenCover(isPresented: $showingSimulationView) {
            ImageManipulationView()
        }
    }
}

#Preview {
    ColorBlindHelpView()
}
