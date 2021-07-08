
//
//  ViewModel.swift
//  SimpleDip
//
//  Created by Matt Stoffel on 6/8/21.
//

import Foundation

class ViewModel: ObservableObject {
    
    static var x = 8
    
    static func createCalculator() -> Model {
        return Model(numberOfDipSwitches: x)
    }
    
    @Published private var model: Model = createCalculator()
    
    var dipSwitches:Array<Model.DipSwitch> {
        model.dipSwitches
    }
    
    var total:String {
        if model.total == 0 {
            return ""
        }
        else {
            return "\(model.total)"
        }
    }
    
    var increment: Int {
        get {
            model.increment
        }
        set {
            model.increment = newValue
        }
        
    }
    
    
    //  MARK: - Intents
    func flipSwitch(_ dipSwitch: Model.DipSwitch) {
        model.flipSwitch(dipSwitch)
    }
    
    func numberChange(input: String, by: Int) {
        let number = (Int(input) ?? 0) + by
        
        if (input.count < 8) {
            model.setTotal(number)
        }
        if number > model.maxTotal() {
            model.setTotal(model.maxTotal())
        }
        if number <= 0 {
            model.setTotal(0)
        }
    }
    
    func setNumberOfDipSwitches(_ sliderValue: Double) {
        model.setNumberOfDipSwitches(Int(sliderValue))
    }
    
}
