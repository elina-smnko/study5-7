//
//  Element.swift
//  Questionaire
//
//  Created by Elina Semenko on 01.02.2022.
//

import Foundation

enum ElementType: String, Codable {
    case title = "Title", form = "TextForm", checkbox = "CheckBox", multiline = "MultilineText"
}

enum HiddenCondition: String, Codable {
    case less = "isLess", greater = "isGreater", greaterEqual = "isGreaterOrEqual", lessEqual = "isLessOrEqual", equal = "isEqual"
}

enum KeyboardType: String, Codable {
    case digit = "Digit", def = "Default"
}

class Hidden: Codable {
    let condition: String
    let idElem: Int
    
    enum CodingKeys: String, CodingKey {
        case idElem = "id_element", condition
    }
}

class Button: Codable {
    let id: Int?
    let title: String?
    
    var isSelected: Bool?
}

class Attribute: Codable {
    let text: String?
    let titleRange: Int?
    let textFieldRange: Int?
    let keyboardType: KeyboardType?
    let multipleChoice: Bool?
    let buttons: [Button]?
    
    var enteredText: String?
    
    enum CodingKeys: String, CodingKey {
        case textFieldRange = "text_field_range", titleRange = "title_range", multipleChoice = "multiply_choise_allowed", keyboardType = "keyboard_type", text, buttons
    }
}

class Element: Codable {
    let type: ElementType?
    let id: Int?
    let position: Int?
    let hidden: Hidden?
    let attributes: Attribute?
    
//    var isHidden: Bool {
//        guard let id = id else {return true}
//        guard let hidden = hidden, let condition = HiddenCondition(rawValue: hidden.condition) else { return false }
//        switch condition {
//        case .less:
//            return id < hidden.idElem
//        case .greater:
//            return id > hidden.idElem
//        case .greaterEqual:
//            return id >= hidden.idElem
//        case .lessEqual:
//            return id <= hidden.idElem
//        case .equal:
//            return id == hidden.idElem
//        }
//    }
    
    
    enum CodingKeys: String, CodingKey {
        case type, id, position, attributes, hidden = "is_hidden"
    }
}

class TasterForm: Codable {
    let elements: [Element]
}
