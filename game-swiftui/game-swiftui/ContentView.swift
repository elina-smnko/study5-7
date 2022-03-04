//
//  ContentView.swift
//  game-swiftui
//
//  Created by Elina Semenko on 18.02.2022.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var matrix = Matrix()
    
    var body: some View {
        Board(matrix: matrix).onTapGesture {
            matrix.move(.down)
        }
            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                                        .onEnded { value in
                                            let horizontalAmount = value.translation.width as CGFloat
                                            let verticalAmount = value.translation.height as CGFloat

                                            if abs(horizontalAmount) > abs(verticalAmount) {
                                                if horizontalAmount < 0 {
                                                    self.matrix.move(.left)
                                                } else {
                                                    self.matrix.move(.right)
                                                }
                                            } else {
                                                if verticalAmount < 0 {
                                                    self.matrix.move(.up)
                                                } else {
                                                    self.matrix.move(.down)
                                                }
                                            }
                                        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
