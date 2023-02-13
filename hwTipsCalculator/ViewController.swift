//
//  ViewController.swift
//  hwTipsCalculator
//
//  Created by Anthony on 13.02.2023.
//

import UIKit

final class ViewController: UIViewController {

    private var textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        addTextField()
    }
    
    final func setupSubviews() {
        title = "TipsCalculator"
        view.backgroundColor = .systemGray4
    }
    
//MARK: - add textFIeld
    final func addTextField() {
        textField.backgroundColor = .white
        textField.textAlignment = .right
        textField.placeholder = "$0.00"
        textField.clearButtonMode = .always
        textField.font = UIFont.systemFont(ofSize: 16 * 3)
        textField.layer.borderWidth = 0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 5
        textField.keyboardType = .decimalPad

//        textField.addTarget(self,
//                            action: #selector(textFieldEdit(sender:)),
//                            for: .valueChanged) // .editingDidBegin
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)

        //        textField.addTarget(self, action: #selector(textFieldAction(sender:)), for: .editingChanged)
    
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16 * 5),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 16 * 4)
        ])
    }

}

