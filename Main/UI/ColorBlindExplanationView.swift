//
//  ColorBlindExplanationView.swift
//
//
//  Created by Tristan Chay on 23/2/24.
//

import SwiftUI

struct ColorBlindExplanationView: View {
    
    @State var steps = 1
    
    @State var showingTestView = false
    
    @State var bubbleSize: CGFloat = 128
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                Image(uiImage: simulateColorBlindness(image: UIImage(named: "threedots")!))
                    .saturation(steps == 9 ? 0 : 1)
                Spacer()
                VStack {
                    if steps == 1 {
                        Text("For most people your red, green, and blue cones are within an acceptable range, and colors appear as they should.")
                    } else if steps == 2 {
                        Text("However, some people may have their color cones shifted outside the acceptable range. This causes light to hit their eyes differently and they perceive colors differently. This is what we call color blindness.")
                    } else if steps == 3 {
                        Text("Contrary to popular belief, color blindness does not mean that a person views the world in black and white/grayscale. This specific type of color blindness only accounts for a small percentage of color blind people.")
                    } else if steps == 4 {
                        Text("Usually color blind people perceive colors differently, and may have difficulties telling apart different colors like red and green or blue and red.")
                    } else if steps == 5 {
                        Text("For example, this is how someone with deuteranopia (green-red color blindness, with sensitivity towards green) views colors.")
                    } else if steps == 6 {
                        Text("This is how someone with protanopia (red-green color blindness, with sensitivity towards red) views colors.")
                    } else if steps == 7 {
                        Text("This is how someone with tritanopia (blue-yellow color blindness) views colors.")
                    } else if steps == 8 {
                        Text("These three color blindness are the most common types of color blindness there are, but a rare 1 in 100,000 people suffer from monochromatism or complete color blindness.")
                    } else if steps == 9 {
                        Text("This is how someone with monochromatism (complete color blindness) views colors.")
                    }
                }
                .font(.title)
                .fontWeight(.heavy)
                .lineLimit(3)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding([.horizontal, .bottom])
                
                Button {
                    if steps < 9 {
                        withAnimation {
                            steps += 1
                        }
                    } else {
                        showingTestView = true
                    }
                } label: {
                    Text(steps == 9 ? "Continue" : "Next")
                        .padding()
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(steps == 9 ? .blue : .orange)
                        .cornerRadius(16)
                }
                .buttonStyle(.plain)
                .padding(.bottom, 30)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .fullScreenCover(isPresented: $showingTestView) {
            ColorBlindTestView()
        }
    }
    
    func simulateColorBlindness(image: UIImage) -> UIImage {
        guard let ciImage = CIImage(image: image) else { return image }
        
        var filter: CIFilter?
        
        if steps == 5 {
            filter = CIFilter(name: "CIColorMatrix")
            filter?.setDefaults()
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
            filter?.setValue(CIVector(x: 0.625, y: 0.375, z: 0.0, w: 0.0), forKey: "inputRVector")
            filter?.setValue(CIVector(x: 0.7, y: 0.3, z: 0.0, w: 0.0), forKey: "inputGVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.3, z: 0.7, w: 0.0), forKey: "inputBVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 1.0), forKey: "inputAVector")
        } else if steps == 6 {
            filter = CIFilter(name: "CIColorMatrix")
            filter?.setDefaults()
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
            filter?.setValue(CIVector(x: 0.567, y: 0.433, z: 0.0, w: 0.0), forKey: "inputRVector")
            filter?.setValue(CIVector(x: 0.558, y: 0.442, z: 0.0, w: 0.0), forKey: "inputGVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.242, z: 0.758, w: 0.0), forKey: "inputBVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 1.0), forKey: "inputAVector")
        } else if steps == 7 {
            filter = CIFilter(name: "CIColorMatrix")
            filter?.setDefaults()
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
            filter?.setValue(CIVector(x: 0.95, y: 0.05, z: 0.0, w: 0.0), forKey: "inputRVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.433, z: 0.567, w: 0.0), forKey: "inputGVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.475, z: 0.525, w: 0.0), forKey: "inputBVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 1.0), forKey: "inputAVector")
        }
        
        if let outputCIImage = filter?.outputImage {
            let context = CIContext(options: nil)
            if let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return image
    }
}
