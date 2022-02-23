//
//  ElementTableViewCell.swift
//  Questionaire
//
//  Created by Elina Semenko on 16.02.2022.
//

import UIKit

class ElementTableViewCell: UITableViewCell {
    
    var width: CGFloat = 0
    
    var element: Element? {
        didSet {
            configure()
        }
    }
    
    let textField = UITextField()
    let stackView = UIStackView()
    let headerTitleLabel = UILabel()
    let mainStackView = UIStackView()
    let textView = UITextView()
    
    func configure() {
        contentView.backgroundColor = .black.withAlphaComponent(0.2)
        configureUI()
        guard let type = element?.type else { return }
        switch type {
        case .title:
            showTitle(element)
        case .form:
            showTextForm(element)
        case .checkbox:
            showCheckBox(element)
        case .multiline:
            showMultiline(element)
        }
    }
    
    private func configureUI() {
        headerTitleLabel.numberOfLines = 0
        headerTitleLabel.adjustsFontSizeToFitWidth = true
        configureStackView()
    }
    
    private func configureStackView() {
        contentView.addSubview(mainStackView)
        mainStackView.frame = bounds
        mainStackView.frame.size.width = width
        mainStackView.distribution = .fillEqually
        mainStackView.axis = .vertical
        mainStackView.subviews.forEach({$0.removeFromSuperview()})
        stackView.subviews.forEach({$0.removeFromSuperview()})
    }
    
    private func showTitle(_ element: Element?) {
        mainStackView.addArrangedSubview(headerTitleLabel)
        headerTitleLabel.text = element?.attributes?.text
    }
    
    private func showCheckBox(_ element: Element?) {
        mainStackView.addArrangedSubview(headerTitleLabel)
        mainStackView.addArrangedSubview(stackView)
        headerTitleLabel.text = element?.attributes?.text

        stackView.backgroundColor = .blue.withAlphaComponent(0.3)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        for b in (element?.attributes?.buttons ?? [Button]()) {
            let button = CheckButton()
            button.buttonInfo = b
            stackView.addArrangedSubview(button)
        }
    }
    
    private func showTextForm(_ element: Element?) {
        textField.delegate = self
        mainStackView.addArrangedSubview(headerTitleLabel)
        mainStackView.addArrangedSubview(textField)
        headerTitleLabel.text = element?.attributes?.text
        textField.backgroundColor = .systemPink.withAlphaComponent(0.2)
        textField.isUserInteractionEnabled = true
        textField.tintColor = .purple
        textField.setLeftPaddingPoints(20)
        textField.tag = element?.attributes?.textFieldRange ?? 0
        
        let keyboardType: KeyboardType = element?.attributes?.keyboardType ?? .def
        switch keyboardType {
        case .digit:
            textField.keyboardType = .numberPad
        case .def:
            textField.keyboardType = .default
        }
    }
    
    private func showMultiline(_ element: Element?) {
        textView.delegate = self
        mainStackView.subviews.forEach({$0.removeFromSuperview()})
        mainStackView.addArrangedSubview(headerTitleLabel)
        mainStackView.addArrangedSubview(textView)
        headerTitleLabel.text = element?.attributes?.text
        
        textView.isUserInteractionEnabled = true
        textView.isEditable = true
        textView.tintColor = .brown.withAlphaComponent(0.1)
        textView.tag = element?.attributes?.textFieldRange ?? 0
        
        let keyboardType: KeyboardType = element?.attributes?.keyboardType ?? .def
        switch keyboardType {
        case .digit:
            textView.keyboardType = .numberPad
        case .def:
            textView.keyboardType = .default
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        element?.attributes?.enteredText = textField.text
    }
}

extension ElementTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = textField.tag
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}

extension ElementTableViewCell: UITextViewDelegate {}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
