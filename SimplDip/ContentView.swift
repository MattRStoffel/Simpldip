//
//  ContentView.swift
//  SimpleDip
//
//  Created by Matt Stoffel on 6/8/21.
//
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State var input: String = ""
    
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    NumberInput(text: $input)
                        .onChange(of: input) { _ in
                            viewModel.numberChange(input: input, by: 0)
                            input = viewModel.total
                        }
                    HStack {
                        MyButton(content: "- \(viewModel.increment)") {
                            viewModel.numberChange(input: input, by: -viewModel.increment)
                            input = viewModel.total
                        }
                        MyButton(content: "+ \(viewModel.increment)") {
                            viewModel.numberChange(input: input, by: viewModel.increment)
                            input = viewModel.total
                        }
                    }
                    HStack {
                        ForEach(viewModel.dipSwitches) {dipSwitch in
                            DipSwitch(dipSwitch: dipSwitch)
                                .onTapGesture {
                                    viewModel.flipSwitch(dipSwitch)
                                    input = viewModel.total
                                }
                        }
                    }
                    .frame(minWidth: 0, idealWidth: 0, maxWidth: 900, minHeight: 0, idealHeight: 0, maxHeight: 120, alignment: .center)
                    .aspectRatio(contentMode: .fill)
                }
                .padding()
                .navigationBarItems(
                    trailing:
                        NavigationLink(
                            destination: DestinationPageView(viewModel: viewModel,
                                                             sliderValue: Double(viewModel.dipSwitches.count),
                                                             increment: String(viewModel.increment)
                            )
                        ) {
                            Image(systemName: "ellipsis")
                                .font(.title)
                                .foregroundColor(.gray)
                                .padding()
                        }
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let x = ViewModel()
        ContentView(viewModel: x)
    }
}
