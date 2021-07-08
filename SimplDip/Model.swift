//
//  Model.swift
//  SimpleDip
//
//  Created by Matt Stoffel on 6/8/21.
//

import Foundation

struct Model {
    private(set) var dipSwitches: Array<DipSwitch>
    var total = 0
    var increment = 1
    func maxTotal() -> Int {
        return Int(NSDecimalNumber(decimal: pow(2, dipSwitches.count)).intValue - 1)
    }
    
    mutating func flipSwitch(_ dipSwitch: Model.DipSwitch) {
        if let chosenIndex = dipSwitches.firstIndex(where: { $0.id == dipSwitch.id}) {
            if dipSwitches[chosenIndex].onOff {
                total -= dipSwitch.value
            } else {
                total += dipSwitch.value
            }
            setTotal(total)
        }
    }
    
    mutating func setTotal(_ input: Int) {
        for index in 0..<dipSwitches.count {
            dipSwitches[index].onOff = false
        }
        total = input
        var tracker = input
        for index in stride(from: dipSwitches.count - 1, to: -1, by: -1) {
            let thisSwitch = dipSwitches[index].value
            if tracker >= thisSwitch {
                tracker -= thisSwitch
                dipSwitches[index].onOff = true
            }
        }
    }
    
    mutating func addSwitch() {
        if dipSwitches.count < 16 {
            dipSwitches.append(Model.DipSwitch(
                                value: Int(pow(2, Double(dipSwitches.count))),
                                id: dipSwitches.count))
        }
    }
    
    mutating func removeSwitch() {
        if dipSwitches.count > 4 {
            let dipswitch = dipSwitches.popLast()
            if dipswitch!.onOff {
                total -= dipswitch!.value
            }
            
        }
    }
    
    mutating func setNumberOfDipSwitches(_ sliderValue: Int) {
        while sliderValue > dipSwitches.count {
            addSwitch()
        }
        while sliderValue < dipSwitches.count {
            removeSwitch()
        }
    }
    
    init(numberOfDipSwitches: Int) {
        dipSwitches = Array<DipSwitch>()
        for index in 0..<numberOfDipSwitches {
            dipSwitches.append(Model.DipSwitch(value: Int(pow(2, Double(index))), id: index))
        }
    }
    
    struct DipSwitch: Identifiable {
        var onOff: Bool = false
        var value: Int
        var id: Int
    }
}
