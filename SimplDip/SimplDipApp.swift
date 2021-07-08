//
//  SimpleDipApp.swift
//  SimpleDip
//
//  Created by Matt Stoffel on 6/8/21.
//


import SwiftUI

@main
struct SimpleDipApp: App {
    var body: some Scene {
        WindowGroup {
            let x = ViewModel()
            ContentView(viewModel: x)
        }
    }
    
}
