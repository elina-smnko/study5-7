//
//  NotesViewModel.swift
//  Questionaire
//
//  Created by Elina Semenko on 02.02.2022.
//

import Foundation
import UIKit

class NotesViewModel {
    var elements: [Element] = [Element]()
    
    init() {
        decodeJSON()
    }
    
    private func decodeJSON() {
        if let path = Bundle.main.path(forResource: "Test", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try? JSONDecoder().decode(TasterForm.self, from: data)
                  if let jsonResult = jsonResult {
                      elements = jsonResult.elements.sorted(by: {($0.position ?? 0) < ($1.position ?? 0)}).filter({!$0.isHidden})
                  }
              } catch {
                  print(error.localizedDescription)
              }
        }
    }
}
