//
//  Tile.swift
//  game-swiftui
//
//  Created by Elina Semenko on 18.02.2022.
//

import SwiftUI

struct Tile: View {
    let value: Int
    let wasAdded: Bool
    private let style: TileStyle
    private let title: String
    private let size: CGFloat = 70
    
    init(_ value: Int, wasAdded: Bool = false) {
        self.wasAdded = wasAdded
        self.value = value
        style = TileStyle(value)
        title = value == 0 ? "" : value.description
    }
    
    private var fontSize: CGFloat {
        switch value {
        case _ where value < 10:
            return 30
        case _ where value < 100:
            return 25
        default:
            return 22
        }
    }
    
    private var shadowColor: Color {
        value == 2048 ? .yellow : .clear
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: fontSize, weight: .black, design: .rounded))
            .foregroundColor(style.foregroundColor)
            .frame(width: size, height: size)
            .background(style.backgroundColor)
            .cornerRadius(3)
            .shadow(color: shadowColor, radius: 4, x: 0, y: 0)
            .animation(wasAdded ? .easeIn : .none, value: 1)
    }
}

enum TileStyle {
    case empty
    case two
    case four
    case eigth
    case sixteen
    case thirtyTwo
    case sixtyFour
    case max
    
    init(_ value: Int) {
        switch value {
        case 0: self = .empty
        case 2: self = .two
        case 4: self = .four
        case 8: self = .eigth
        case 16: self = .sixteen
        case 32: self = .thirtyTwo
        case 64: self = .sixtyFour
        default: self = .max
        }
    }
    
    var backgroundColor: Color {
        switch self {
        default:
            return .blue.opacity(0.5)
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .two, .four: return .blue
        default: return .white
        }
    }
}

