//
//  CheckButton.swift
//  Questionaire
//
//  Created by Elina Semenko on 16.02.2022.
//

import UIKit

class CheckButton: UIButton {
    var buttonInfo: Button? = nil {
        didSet {
            buttonInfo?.isSelected = false
            setTitle(buttonInfo?.title, for: .normal)
            self.layer.backgroundColor = UIColor.purple.withAlphaComponent(0.5).cgColor
        }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        titleLabel?.adjustsFontSizeToFitWidth = true
        setTitleColor(.white, for: .normal)
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            buttonInfo?.isSelected?.toggle()
            if buttonInfo?.isSelected == true {
                self.layer.backgroundColor = UIColor.purple.cgColor
                NotesViewModel.selectElement(id: buttonInfo?.id ?? -1)
            } else {
                self.layer.backgroundColor = UIColor.purple.withAlphaComponent(0.5).cgColor
            }
        }
    }
}
