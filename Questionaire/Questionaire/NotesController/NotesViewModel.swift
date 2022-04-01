//
//  NotesViewModel.swift
//  Questionaire
//
//  Created by Elina Semenko on 02.02.2022.
//

import Foundation
import UIKit

class NotesViewModel {
    static var elements: [Element] = [Element]()
    static var selectedElements = Set<Int>() {
        didSet {
            updateShown()
        }
    }
    static var shownElements = [Element]()
    
    private static var age = 0 {
        didSet {
            updateShown()
        }
    }
    
    init() {
        NotesViewModel.decodeJSON()
    }
    
    private static func decodeJSON() {
        if let path = Bundle.main.path(forResource: "Test", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try? JSONDecoder().decode(TasterForm.self, from: data)
                  if let jsonResult = jsonResult {
                      elements = jsonResult.elements.sorted(by: {($0.position ?? 0) < ($1.position ?? 0)})
                      shownElements = elements
                      print(shownElements)
                  }
              } catch {
                  print(error.localizedDescription)
              }
        }
    }
    
    static func updateAge(value: Int) {
        age = value
    }
    
    static func selectElement(id: Int) {
        selectedElements.insert(id)
    }
    
    private static func updateShown() {
        shownElements = [Element]()
        for element in elements {
            if element.hidden?.condition == "isEqual" &&  selectedElements.contains(element.hidden?.idElem ?? -1) && element.hidden != nil || element.id == 1 || element.id == 10 {
                shownElements.append(element)
            }
            else if element.hidden?.condition == "isLess" && element.hidden?.idElem == 10 || element.id == 1 || element.id == 10 {
                if age < 18 {
                    shownElements.append(element)
                }
            }
            
            else if element.hidden?.condition == "isGreaterOrEqual" && element.hidden?.idElem == 10 || element.id == 1 || element.id == 10 {
                if age >= 18 {
                    shownElements.append(element)
                }
            }
        }
    }
}
