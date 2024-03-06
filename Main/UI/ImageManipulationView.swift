//
//  ImageManipulationView.swift
//  Colorfull
//
//  Created by Tristan Chay on 3/2/24.
//

import SwiftUI

struct ImageManipulationView: View {
    
    @State var selection = 0
    
    @State private var simulateDeuteranopia = false
    @State private var simulateProtanopia = false
    @State private var simulateTritanopia = false
    
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    
    @State var showEndView = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                if let image = selectedImage {
                    VStack {
                        Text("Color Blindness Simulation")
                            .font(.title)
                        
                        // Toggle buttons to enable/disable simulations
//                        Toggle("Deuteranopia", isOn: $simulateDeuteranopia)
//                            .padding()
//                        
//                        Toggle("Protanopia", isOn: $simulateProtanopia)
//                            .padding()
//                        
//                        Toggle("Tritanopia", isOn: $simulateTritanopia)
//                            .padding()
                        
                        Picker("", selection: $selection) {
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
                        .onChange(of: selection) {
                            if selection == 0 || selection == 4 {
                                simulateDeuteranopia = false
                                simulateProtanopia = false
                                simulateTritanopia = false
                            } else if selection == 1 {
                                simulateDeuteranopia = true
                                simulateProtanopia = false
                                simulateTritanopia = false
                            } else if selection == 2 {
                                simulateDeuteranopia = false
                                simulateProtanopia = true
                                simulateTritanopia = false
                            } else if selection == 3 {
                                simulateDeuteranopia = false
                                simulateProtanopia = false
                                simulateTritanopia = true
                            }
                        }
                        
                        // View with simulated colors
                        ColorBlindnessSimulator(
                            deuteranopia: simulateDeuteranopia,
                            protanopia: simulateProtanopia,
                            tritanopia: simulateTritanopia,
                            image: image
                        )
                        .saturation(selection == 4 ? 0 : 1)
                        
                        HStack {
                            Button {
                                selectedImage = nil
                            } label: {
                                Text("Take another photo")
                                    .padding()
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 250, height: 50)
                                    .background(.red)
                                    .cornerRadius(16)
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                showEndView = true
                            } label: {
                                Text("Continue to End")
                                    .padding()
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 250, height: 50)
                                    .background(.blue)
                                    .cornerRadius(16)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.bottom, 30)
                    }
                } else {
                    CameraView(isShown: $isImagePickerPresented, image: $selectedImage)
                }
            }
        }
        .fullScreenCover(isPresented: $showEndView) {
            EndView()
        }
    }
}

#Preview {
    ImageManipulationView()
}
