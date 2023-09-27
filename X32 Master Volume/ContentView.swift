//
//  ContentView.swift
//  X32 Master Volume
//
//  Created by Adam Ware on 25/9/2023.
//

import SwiftUI
import Sliders

struct ContentView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ValueSlider(value: $viewModel.currentVolume)
                    .valueSliderStyle(
                        VerticalValueSliderStyle(track:
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [.red, .orange, .yellow, Color.teal, Color.teal, .blue, .blue]),
                                                        startPoint: .top, endPoint: .bottom
                                                    )
                                                        .frame(width: 8)
                                                        .cornerRadius(4),
                                                 thumbSize: CGSize(width: 42, height: 16))
                    )
                Text("Master")
                    .font(.system(size: 12, weight: .bold))
                Button("Close", role: .cancel) {
                    viewModel.closeApplication()
                }
            }
        }
        .alert(viewModel.errorString ?? "", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {
                viewModel.showError = false
            }
        }
        .padding()
        .onAppear() {
            self.viewModel.setupMidi()
        }
        
    }
}

#Preview {
    ContentView()
}
