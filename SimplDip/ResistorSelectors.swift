//
//  ResistorSelectors.swift
//  SimplDip
//
//  Created by Matt Stoffel on 12/17/21.
//

import SwiftUI


struct NumericalSelector: View {
    @Binding var selectedColor: ColorCode
    @State var index = 0
    
    var body: some View {
        let MyRectangle = Rectangle().frame(width: 50, height: 40)
        VStack {
            MyRectangle.foregroundColor(.black).tag(ColorCode.black)
            MyRectangle.foregroundColor(Color(CGColor(red: 0.59, green: 0.29, blue: 0, alpha: 256))).tag(ColorCode.brown)
            MyRectangle.foregroundColor(.red).tag(ColorCode.red)
            MyRectangle.foregroundColor(.orange).tag(ColorCode.orange)
            MyRectangle.foregroundColor(.yellow).tag(ColorCode.yellow)
            MyRectangle.foregroundColor(.green).tag(ColorCode.green)
            MyRectangle.foregroundColor(.blue).tag(ColorCode.blue)
            MyRectangle.foregroundColor(.purple).tag(ColorCode.purple)
            MyRectangle.foregroundColor(.gray).tag(ColorCode.gray)
            MyRectangle.foregroundColor(.white).tag(ColorCode.white)
        }
        .frame(width: 50, height: 90)
        .modifier(ScrollingVStackModifier(items: 10, itemHeight: 40, itemSpacing: 8, selectedItem: $index))
        .clipped()
        .onChange(of: index){ num in
            selectedColor = ColorCode.allCases[index]
        }
    }
    
}

struct MultiplyerSelector: View {
    @Binding var selectedColor: Multiplyer
    @State var index = 0
    
    var body: some View {
        let MyRectangle = Rectangle().frame(width: 50, height: 40)
        VStack {
            MyRectangle.foregroundColor(.black).tag(Multiplyer.black)
            MyRectangle.foregroundColor(Color(CGColor(red: 0.59, green: 0.29, blue: 0, alpha: 256))).tag(Multiplyer.brown)
            MyRectangle.foregroundColor(.red).tag(Multiplyer.red)
            MyRectangle.foregroundColor(.orange).tag(Multiplyer.orange)
            MyRectangle.foregroundColor(.yellow).tag(Multiplyer.yellow)
            MyRectangle.foregroundColor(.green).tag(Multiplyer.green)
            MyRectangle.foregroundColor(.blue).tag(Multiplyer.blue)
            MyRectangle.foregroundColor(.purple).tag(Multiplyer.purple)
            MyRectangle.foregroundColor(Color(CGColor(red: 0.9, green: 0.6, blue: 0, alpha: 256))).tag(Multiplyer.gold)
            MyRectangle.foregroundColor(Color(CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 256))).tag(Multiplyer.silver)
        }
        .frame(width: 50, height: 90)
        .modifier(ScrollingVStackModifier(items: 10, itemHeight: 40, itemSpacing: 8, selectedItem: $index))
        .clipped()
        .onChange(of: index){ num in
            selectedColor = Multiplyer.allCases[index]
        }
    }
}



struct ToloranceSelector: View {
    @Binding var selectedColor: Tolerance
    @State var index = 0
    
    var body: some View {
        let MyRectangle = Rectangle().frame(width: 50, height: 40)
        VStack {
            MyRectangle.foregroundColor(Color(CGColor(red: 0.59, green: 0.29, blue: 0, alpha: 256))).tag(Tolerance.brown)
            MyRectangle.foregroundColor(.red).tag(Tolerance.red)
            MyRectangle.foregroundColor(.green).tag(Tolerance.green)
            MyRectangle.foregroundColor(.blue).tag(Tolerance.blue)
            MyRectangle.foregroundColor(.purple).tag(Tolerance.purple)
            MyRectangle.foregroundColor(.gray).tag(Tolerance.gray)
            MyRectangle.foregroundColor(Color(CGColor(red: 0.9, green: 0.6, blue: 0, alpha: 256))).tag(Tolerance.gold)
            MyRectangle.foregroundColor(Color(CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 256))).tag(Tolerance.silver)
        }
        .frame(width: 50, height: 90)
        .modifier(ScrollingVStackModifier(items: 8, itemHeight: 40, itemSpacing: 8, selectedItem: $index))
        .clipped()
        .onChange(of: index){ num in
            selectedColor = Tolerance.allCases[index]
        }
    }
}


enum ColorCode: Int, CaseIterable, Identifiable {
    case white  = 9
    case gray   = 8
    case purple = 7
    case blue   = 6
    case green  = 5
    case yellow = 4
    case orange = 3
    case red    = 2
    case brown  = 1
    case black  = 0
    
    var id: Int { self.rawValue }
}
enum Multiplyer: String, CaseIterable, Identifiable {
    case silver = "0.01"
    case gold   = "0.1"
    case purple = "0M"
    case blue   = "M"
    case green  = "00k"
    case yellow = "0k"
    case orange = "k"
    case red    = "00"
    case brown  = "0"
    case black  = ""
    
    var id: String { self.rawValue }
}

enum Tolerance: Double, CaseIterable, Identifiable {
    case silver = 10.0
    case gold   = 5.0
    case gray   = 0.05
    case purple = 0.1
    case blue   = 0.25
    case green  = 0.5
    case red    = 2.0
    case brown  = 1.0
    
    var id: Double { self.rawValue }
}

struct ScrollingVStackModifier: ViewModifier {
    
    @State private var scrollOffset: CGFloat
    @State private var dragOffset: CGFloat
    
    var items: Int
    var itemHeight: CGFloat
    var itemSpacing: CGFloat
    
    @Binding var selectedItem: Int
    
    init(items: Int, itemHeight: CGFloat, itemSpacing: CGFloat, selectedItem: Binding<Int>) {
        self.items = items
        self.itemHeight = itemHeight
        self.itemSpacing = itemSpacing
        
        // Calculate Total Content Height
        let contentHeight: CGFloat = CGFloat(items) * itemHeight + CGFloat(items - 1) * itemSpacing
        let screenHeight = contentHeight
        
        // Set Initial Offset to first Item
        let initialOffset = (contentHeight/2.0) - (screenHeight/2.0) + ((screenHeight - itemHeight) / 2.0)
        
        self._scrollOffset = State(initialValue: initialOffset)
        self._dragOffset = State(initialValue: 0)
        
        self._selectedItem = selectedItem
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: 0, y: scrollOffset + dragOffset)
            .gesture(DragGesture()
                .onChanged({ event in
                    dragOffset = event.translation.height
                })
                .onEnded({ event in
                    // Scroll to where user dragged
                    scrollOffset += event.translation.height
                    dragOffset = 0
                    
                    // Now calculate which item to snap to
                    let contentHeight: CGFloat = CGFloat(items) * itemHeight + CGFloat(items - 1) * itemSpacing
                    let screenHeight = contentHeight
                    
                    // Center position of current offset
                    let center = scrollOffset + (screenHeight / 2.0) + (contentHeight / 2.0)
                    
                    // Calculate which item we are closest to using the defined size
                    var index = (center - (screenHeight / 2.0)) / (itemHeight + itemSpacing)
                    
                    // Should we stay at current index or are we closer to the next item...
                    if index.remainder(dividingBy: 1) > 0.5 {
                        index += 1
                    } else {
                        index = CGFloat(Int(index))
                    }
                    
                    // Protect from scrolling out of bounds
                    index = min(index, CGFloat(items) - 1)
                    index = max(index, 0)
                
                selectedItem = Int(index)
                    
                    // Set final offset (snapping to item)
                    let newOffset = index * itemHeight + (index - 1) * itemSpacing - (contentHeight / 2.0) + (screenHeight / 2.0) - ((screenHeight - itemHeight) / 2.0) + itemSpacing
                    
                    // Animate snapping
                    withAnimation {
                        scrollOffset = newOffset
                    }
                    
                })
            )
    }
}
