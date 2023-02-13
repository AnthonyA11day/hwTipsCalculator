//
//  ViewController.swift
//  hwTipsCalculator
//
//  Created by Anthony on 13.02.2023.
//

import UIKit

final class ViewController: UIViewController {

    private var textField = UITextField()
    private var slider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    final func setupSubviews() {
        title = "TipsCalculator"
        view.backgroundColor = .systemGray4
        
        addTextField()
        addSlider()
    }
    
//MARK: - textFIeld add
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
    
//MARK: - slider add
    func addSlider() {
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 17))
        slider.minimumTrackTintColor = .systemBlue
        slider.maximumTrackTintColor = .systemGray
        slider.minimumValue = 0.0
        slider.maximumValue = 50.0
        slider.value = 10.0
        slider.isEnabled = false
        slider.addTarget(self,
                         action: #selector(sliderChangeValue(sender:)),
                         for: .valueChanged)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16 * 6),
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            slider.heightAnchor.constraint(equalToConstant: 16 * 4)
        ])
    }
    
    @objc func sliderChangeValue(sender: UISlider) {
        
        
    }
}



