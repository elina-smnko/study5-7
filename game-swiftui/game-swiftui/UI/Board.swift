//
//  Board.swift
//  game-swiftui
//
//  Created by Elina Semenko on 18.02.2022.
//

import SwiftUI

struct Board: View {
    @ObservedObject var matrix: Matrix
    var addedTile: (Int, Int)? = nil
    
    private func wasAdded(row: Int, column: Int) -> Bool {
        addedTile?.0 == row && addedTile?.1 == column
    }
    
    var body: some View {
        VStack {
            ForEach(matrix.value.indices, id: \.self) { i in
            HStack{
                ForEach(matrix.value[i].indices, id: \.self) { j in
                  return Tile(matrix.value[i][j], wasAdded: wasAdded(row: i, column: j))
              }
            }
          }
        }
        .padding(8)
        .background(Color.pink.opacity(0.5))
        .cornerRadius(4)
    }
}
