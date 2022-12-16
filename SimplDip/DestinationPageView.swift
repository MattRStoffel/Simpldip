//
//  DestinationPageView.swift
//  SimpleDip
//
//  Created by Matt Stoffel on 6/14/21.
//

import SwiftUI

struct DestinationPageView: View {
    @ObservedObject var viewModel: ViewModel
    @State var sliderValue: Double
    @State var increment: String
    
    var body: some View {
        VStack {
            Text("Set Increment")
            NumberInput(text: $increment)
                .onDisappear(perform: {
                    viewModel.increment = Int(increment) ?? 1
                })
                .padding()
                .aspectRatio(4, contentMode: .fit)
            
            Text("\(Int(sliderValue)) Dip Switches")
            Slider(value: $sliderValue, in: 4...16, step: 1)
                .padding()
                .onDisappear(perform: {
                    viewModel.setNumberOfDipSwitches(sliderValue)
                })
            Spacer()
        }
    }
}

struct DestinationPageView_Previews: PreviewProvider {
    static var previews: some View {
        let x = ViewModel()
        DestinationPageView(viewModel: x, sliderValue: 8, increment: "1")
    }
}

