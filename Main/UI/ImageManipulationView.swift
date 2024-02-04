//
//  ImageManipulationView.swift
//  Colorfull
//
//  Created by Tristan Chay on 3/2/24.
//

import SwiftUI

struct ImageManipulationView: View {
    
    @State private var simulateDeuteranopia = false
    @State private var simulateProtanopia = false
    @State private var simulateTritanopia = false
    
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            if let image = selectedImage {
                VStack {
                    Text("Color Blindness Simulation")
                        .font(.title)

                    // Toggle buttons to enable/disable simulations
                    Toggle("Deuteranopia", isOn: $simulateDeuteranopia)
                        .padding()

                    Toggle("Protanopia", isOn: $simulateProtanopia)
                        .padding()

                    Toggle("Tritanopia", isOn: $simulateTritanopia)
                        .padding()

                    // View with simulated colors
                    ColorBlindnessSimulator(
                        deuteranopia: simulateDeuteranopia,
                        protanopia: simulateProtanopia,
                        tritanopia: simulateTritanopia,
                        image: image
                    )
                    .padding()
                }
            } else {
                CameraView(isShown: $isImagePickerPresented, image: $selectedImage)
            }
        }
    }
}

#Preview {
    ImageManipulationView()
}
