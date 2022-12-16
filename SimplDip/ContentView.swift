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
    @ObservedObject var rvm: ResistorViewModel
    @State var input: String = ""
    @State private var rect1: CGRect = .zero
    @State private var rect2: CGRect = .zero
    @State private var uiimage: UIImage? = nil
    @State var share: String? = "https://apps.apple.com/us/app/simpldip/id1571350216"
    
    
    var SwitchPacket: some View {
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
    
    var StepperButtons: some View {
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
    }
    
    func shareSwitches() {
        let switches = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: self.rect1)
        let numbers = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: self.rect2)
        
        let newSize = CGSize(width: max(rect1.width, rect2.width), height: rect1.height + rect2.height)
        let background = UIImage(color: .black, size: newSize)
        let shareRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContext(newSize)

        background!.draw(in: shareRect)
        switches!.draw(at: CGPoint(x: 0, y: rect2.height))
        numbers!.draw(at: .zero)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        let activityVC = UIActivityViewController(activityItems: [share, newImage], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: false, completion: nil)
        share = nil
    }
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            shareSwitches()
                        })
                        {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title2)
                        }
                        .padding()
                    }
                    NumberInput(text: $input)
                        .background(SnaphotFrame(rect: $rect2).padding(-8))
                        .onChange(of: input) { _ in
                            viewModel.numberChange(input: input, by: 0)
                            input = viewModel.total
                        }
                    StepperButtons
                    SwitchPacket
                        .background(SnaphotFrame(rect: $rect1).padding(-8))
                }
                .padding()
                .navigationBarItems(
                    leading: NavigationLink(
                        destination: ResistorView(rvm: rvm)
                    ) {
                        Text("Ω")
                            .font(.title)
                            .padding()
                    },
                    trailing:
                        NavigationLink(
                            destination: DestinationPageView(viewModel: viewModel,
                                                             sliderValue: Double(viewModel.dipSwitches.count),
                                                             increment: String(viewModel.increment)
                                                            )
                        ) {
                            Image(systemName: "ellipsis")
                                .font(.title)
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
        let rvm = ResistorViewModel()
        ContentView(viewModel: x, rvm: rvm)
    }
}

struct SnaphotFrame: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { proxy in
            self.createView(proxy: proxy)
        }
    }

    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

public extension UIImage {
  convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
}
