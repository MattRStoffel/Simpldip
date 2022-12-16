//
//  ResistorView.swift
//  SimplDip
//
//  Created by Matt Stoffel on 7/8/21.
//

import SwiftUI



struct ResistorView: View {
    
    @ObservedObject var rvm: ResistorViewModel
    @State var extraBand = false
    @State var selectedColor1 = ColorCode.black
    @State var selectedColor2 = ColorCode.black
    @State var selectedColor3 = ColorCode.black
    @State var selectedColor4 = Multiplyer.black
    @State var selectedColor5 = Tolerance.brown
    
    var body: some View {
        VStack {
            HStack {
                if extraBand {
                    NumericalSelector(selectedColor: $selectedColor1)
                }
                NumericalSelector(selectedColor: $selectedColor2)
                NumericalSelector(selectedColor: $selectedColor3)
                MultiplyerSelector(selectedColor: $selectedColor4)
                ToloranceSelector(selectedColor: $selectedColor5)
            }
            
            HStack (alignment: .center, spacing: 80) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundColor(.black)
                        .opacity(0.2)
                        .onTapGesture {
                            extraBand.toggle()
                            if !extraBand {
                                selectedColor1 = ColorCode.black
                            }
                        }
                    if extraBand { Text("Less") }
                    else { Text("More") }
                }
                .frame(width: 100, height: 50)
                if selectedColor4 == .gold {
                    Text("\(gold.removeZerosFromEnd())" + " ± \(selectedColor5.rawValue)%").foregroundColor(.black)

                }
                else if selectedColor4 == .silver {
                    Text("\(silver.removeZerosFromEnd())" + " ± \(selectedColor5.rawValue)%").foregroundColor(.black)

                }
                else if selectedColor4 == .red {
                    Text("\(red.removeZerosFromEnd())" + "k" + " ± \(selectedColor5.rawValue)%" ).foregroundColor(.black)

                }
                else if selectedColor4 == .green {
                    Text("\(green.removeZerosFromEnd())" + "M" + " ± \(selectedColor5.rawValue)%" ).foregroundColor(.black)

                }
                else {
                    Text("\((selectedColor1.rawValue * 100) + (selectedColor2.rawValue * 10) + (selectedColor3.rawValue))" + selectedColor4.rawValue + " ± \(selectedColor5.rawValue)%").foregroundColor(.black)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 25.0).foregroundColor(.white))
    }
    var gold: Double {
        Double(((selectedColor1.rawValue * 100) + (selectedColor2.rawValue * 10) + (selectedColor3.rawValue))) * 0.1
    }
    var silver: Double {
        Double(((selectedColor1.rawValue * 100) + (selectedColor2.rawValue * 10) + (selectedColor3.rawValue))) * 0.01
    }
    var red: Double {
        Double(((selectedColor1.rawValue * 100) + (selectedColor2.rawValue * 10) + (selectedColor3.rawValue))) * 0.1
    }
    var green: Double {
        Double(((selectedColor1.rawValue * 100) + (selectedColor2.rawValue * 10) + (selectedColor3.rawValue))) * 0.1
    }
}

struct ResistorView_Previews: PreviewProvider {
    static var previews: some View {
        let rvm = ResistorViewModel()
        ResistorView(rvm: rvm)
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
