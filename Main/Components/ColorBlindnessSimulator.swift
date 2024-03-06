//
//  ColorBlindnessSimulator.swift
//  Colorfull
//
//  Created by Tristan Chay on 3/2/24.
//

import SwiftUI

struct ColorBlindnessSimulator: View {
    var deuteranopia: Bool
    var protanopia: Bool
    var tritanopia: Bool
    
    @State var image: UIImage
    
    var body: some View {
        VStack {
            Image(uiImage: simulateColorBlindness(image: image))
                .resizable()
                .scaledToFit()
                .frame(width: 800)
        }
    }
    
    func simulateColorBlindness(image: UIImage) -> UIImage {
        guard let ciImage = CIImage(image: image) else { return image }
        
        var filter: CIFilter?
        
        if deuteranopia {
            filter = CIFilter(name: "CIColorMatrix")
            filter?.setDefaults()
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
            filter?.setValue(CIVector(x: 0.625, y: 0.375, z: 0.0, w: 0.0), forKey: "inputRVector")
            filter?.setValue(CIVector(x: 0.7, y: 0.3, z: 0.0, w: 0.0), forKey: "inputGVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.3, z: 0.7, w: 0.0), forKey: "inputBVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 1.0), forKey: "inputAVector")
        } else if protanopia {
            filter = CIFilter(name: "CIColorMatrix")
            filter?.setDefaults()
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
            filter?.setValue(CIVector(x: 0.567, y: 0.433, z: 0.0, w: 0.0), forKey: "inputRVector")
            filter?.setValue(CIVector(x: 0.558, y: 0.442, z: 0.0, w: 0.0), forKey: "inputGVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.242, z: 0.758, w: 0.0), forKey: "inputBVector")
            filter?.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 1.0), forKey: "inputAVector")
        } else if tritanopia {
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
