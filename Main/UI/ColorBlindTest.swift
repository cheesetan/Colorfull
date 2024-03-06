//
//  ColorBlindTestView.swift
//
//
//  Created by Tristan Chay on 25/2/24.
//

import SwiftUI

struct ColorBlindTestView: View {
    
    @State var showingHelpView = false
    
    @State var filterSelection = 0
    
    @State var tried = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                Picker("", selection: $filterSelection) {
                    Text("None")
                        .tag(0)
                    Text("Deuteranopia")
                        .tag(1)
                    Text("Protanopia")
                        .tag(2)
                    Text("Tritanopia")
                        .tag(3)
                    Text("Monochromatism")
                        .tag(4)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Image(uiImage: simulateColorBlindness(image: UIImage(named: "cbtest")!))
                    .resizable()
                    .scaledToFit()
                    .saturation(filterSelection == 4 ? 0 : 1)
                    .frame(height: 500)
                
                Spacer()
                
                if !tried {
                    Text("Try testing yourself by changing the color blindness filters!")
                        .font(.title)
                        .fontWeight(.heavy)
                        .lineLimit(3)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                }
                
                if tried {
                    Button {
                        showingHelpView = true
                    } label: {
                        Text("Continue")
                            .padding()
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 250, height: 50)
                            .background(.blue)
                            .cornerRadius(16)
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 30)
                }
            }
        }
        .onChange(of: filterSelection) {
            withAnimation {
                tried = true
            }
        }
        .fullScreenCover(isPresented: $showingHelpView) {
            ColorBlindHelpView()
        }
    }
    
    func simulateColorBlindness(image: UIImage) -> UIImage {
        guard let ciImage = CIImage(image: image) else { return image }
        
        var filter: CIFilter?
        
        if filterSelection == 1 {
            filter = CIFilter(name: "CIColorMatrix")
            filter?.setDefaults()
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
            filter?.setValue(CIVector(x: 0.625, y: 0.375, z: 0.0, w: 0.0), forKey: "inputRVector")
            filter?.setValue(CIVector(x: 0.7, y: 0.3, z: 0.0, w: 0.0), forKey: "inputGVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.3, z: 0.7, w: 0.0), forKey: "inputBVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 1.0), forKey: "inputAVector")
        } else if filterSelection == 2 {
            filter = CIFilter(name: "CIColorMatrix")
            filter?.setDefaults()
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
            filter?.setValue(CIVector(x: 0.567, y: 0.433, z: 0.0, w: 0.0), forKey: "inputRVector")
            filter?.setValue(CIVector(x: 0.558, y: 0.442, z: 0.0, w: 0.0), forKey: "inputGVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.242, z: 0.758, w: 0.0), forKey: "inputBVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 1.0), forKey: "inputAVector")
        } else if filterSelection == 3 {
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

#Preview {
    ColorBlindTestView()
}
