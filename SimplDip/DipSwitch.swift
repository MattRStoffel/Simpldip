//
//  DipSwitch.swift
//  SimpleDip
//
//  Created by Matt Stoffel on 6/8/21.
//

import SwiftUI

struct DipSwitch: View {
    var dipSwitch: Model.DipSwitch
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 6)
            .aspectRatio(3/5, contentMode: .fit)
            .padding(6)
            .foregroundColor(.white)
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(.secondary)                
                VStack {
                    if dipSwitch.onOff {
                        shape
                        Spacer()
                    } else {
                        Spacer()
                        shape
                    }
                }
            }
            .aspectRatio(1/3, contentMode: .fit)
            Text("\(dipSwitch.id + 1)")
                .font(.caption2.bold())
                .foregroundColor(.primary)
                .padding(.leading, -8)
                .padding(-6)
        }
    }
}
