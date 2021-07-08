//
//  MyButton.swift
//  SimpleDip
//
//  Created by Matt Stoffel on 6/10/21.
//

import SwiftUI

struct MyButton: View {
    let content: String
    let function: () -> Void
    var body: some View {
        Button(action: function) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.secondary)
                Text(content).font(.title2.bold())
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}
