//
//  ViewController.swift
//  CurrencyMaskFortextFields
//
//  Created by Paolo Prodossimo Lopes on 30/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return view
    }()
    
    private lazy var currencyTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        tf.placeholder = "Ex: R$ 0,00"
        tf.layer.cornerRadius = 8
        tf.leftView = spacerView
        tf.leftViewMode = .always
        tf.keyboardType = .numberPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(validateTextField), for: .editingChanged)
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(currencyTextField)
        NSLayoutConstraint.activate([
            currencyTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currencyTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currencyTextField.heightAnchor.constraint(equalToConstant: 40),
            currencyTextField.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func validateTextField(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        let numberWithOnlyNumbers = text.onlyNumbers()
        let numberValue = Int(numberWithOnlyNumbers) ?? 0
        let doubleValue = Double(numberValue) / 100.0
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-br")
        formatter.numberStyle = .currency
        
        textField.text = formatter.string(from: doubleValue as NSNumber)
    }
}

extension String {
    func onlyNumbers() -> String {
        self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    }
}
