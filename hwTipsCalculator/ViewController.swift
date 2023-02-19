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
    
    private var tipPercentValueLabel = UILabel()
    private var tipValue: Double = 0.0
    private var tipValueLabel = UILabel()
    private var tipPercentValue: Double = 0.0
    private var totalLabel = UILabel()
    private var totalValueLabel = UILabel()
    private var totalValue: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    final func setupSubviews() {
        title = "TipsCalculator"
        view.backgroundColor = .systemGray4
        addTextField()
        addSlider()
        addLabels()
        addLabelsConstraints()
        addDoneButton()
        textField.delegate = self
    }
    
//MARK: - add textFIeld
    final func addTextField() {
        textField.backgroundColor = .white
        textField.textAlignment = .right
        textField.placeholder = "$0.00"
        textField.font = UIFont.systemFont(ofSize: 16 * 3)
        textField.layer.borderWidth = 0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 5
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16 * 5),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 16 * 4)
        ])
    }
    
//MARK: - add slider
    final func addSlider() {
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
        if sender == slider {
            calculator()
        }
    }
    
//MARK: - add labels
    final func addLabels() {
        tipPercentValueLabel.text = "Tip (10.0%)"
        tipValueLabel.text = "$0.00"
        totalLabel.text = "Total:"
        totalValueLabel.text = "$0.00"

        [tipPercentValueLabel, tipValueLabel, totalLabel, totalValueLabel].forEach { label in
            label.font = .boldSystemFont(ofSize: 14)
            label.textAlignment = .right
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
        }
    }
    
//MARK: - create labels contraints
    final func addLabelsConstraints() {
        
        NSLayoutConstraint.activate([
            tipPercentValueLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16 * 1),
            tipPercentValueLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0 * 0),
            tipPercentValueLabel.widthAnchor.constraint(equalToConstant: 16 * 7),
            tipPercentValueLabel.heightAnchor.constraint(equalToConstant: 16 * 2),

            tipValueLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16 * 1),
            tipValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tipValueLabel.widthAnchor.constraint(equalToConstant: 16 * 4),
            tipValueLabel.heightAnchor.constraint(equalToConstant: 16 * 2),

            totalLabel.topAnchor.constraint(equalTo: tipPercentValueLabel.bottomAnchor, constant: 16 * 1),
            totalLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0 * 0),
            totalLabel.widthAnchor.constraint(equalToConstant: 16 * 7),
            totalLabel.heightAnchor.constraint(equalToConstant: 16 * 2),
            
            totalValueLabel.topAnchor.constraint(equalTo: tipPercentValueLabel.bottomAnchor, constant: 16 * 1),
            totalValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            totalValueLabel.widthAnchor.constraint(equalToConstant: 16 * 4),
            totalValueLabel.heightAnchor.constraint(equalToConstant: 16 * 2)
        ])
    }
    
//MARK: - add DONE button
    final func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        ]
        toolbar.sizeToFit()
        toolbar.backgroundColor = .systemGray5
        textField.inputAccessoryView = toolbar
    }

    @objc func doneButtonTapped() {
        print("tapped Done")
        textField.resignFirstResponder()
        slider.isEnabled = true
        calculator()
        if !( textField.text ?? "").contains("$") { textField.text = "$\(textField.text ?? "")" }
    }

//MARK: - add calculation method
    final func calculator() {
        let sliderPercentValue = Double(slider.value)
        tipPercentValueLabel.text = "Tip (\(String( NSString(format: "%.1f", sliderPercentValue) ))%)"

        let textFieldString = textField.text ?? ""
        let textFieldDot = String( textFieldString.map { $0 == "," ? "." : $0 } )
        let textFieldS = String( textFieldDot.map { $0 == "$" ? "0" : $0 } )
        let textFieldValue = Double( textFieldS ) ?? 0

        tipValue = textFieldValue * sliderPercentValue / 100
        tipValue = round(tipValue / 0.05) * 0.05
        tipValueLabel.text = String( NSString(format: "%.2f", tipValue) )
        
        totalValue = textFieldValue + tipValue
        totalValueLabel.text = String( NSString(format: "%.2f", totalValue) )
        }
}

//MARK: - textField Delegate
extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //number formatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = .current
        formatter.roundingMode = .down
        formatter.usesGroupingSeparator = false

        //all possible digits
        let allowChatacters = "0123456789,."

        //all possible math operation symbols user can add
        let symbolsSet = Set(["+","-","x","/"])
        var amountOfSymbols = 0

        let numberString = textField.text ?? ""
        let allowCharactersSet = CharacterSet(charactersIn: allowChatacters)
        let typedCharacterseIn = CharacterSet(charactersIn: string)
        guard allowCharactersSet.isSuperset(of: typedCharacterseIn) else { return false }

        guard let range = Range(range, in: numberString) else { return false }
        let updatedString = numberString.replacingCharacters(in: range, with: string)
        let correctDecimalString = updatedString.replacingOccurrences(of: formatter.groupingSeparator, with: "")
        let completeString = correctDecimalString.replacingOccurrences(of: formatter.decimalSeparator, with: ".")

        //current math symbol user add
        let symbol = symbolsSet.filter(completeString.contains).last ?? ""
        //if user add math symbol to an empty string - do not insert
        if string == symbol, numberString.count == 0 { return false }

        //count how much math symbols string has. If more that one - do not insert, string can have only one
        completeString.forEach { character in
            if symbolsSet.contains(String(character)) {
                amountOfSymbols += 1
            }
        }
        if amountOfSymbols > 1 { return false }

        //count how much decimals string has. If more that one - do not insert because it can have only one per number
        let numbersArray = completeString.components(separatedBy: symbol)
        for number in numbersArray {
            let amountOfDecimalSigns = number.filter({$0 == "."}).count
            if amountOfDecimalSigns > 1 { return false }
        }

        //create numbers from a string
        guard let firstNumber = Double(String(numbersArray.first ?? "0")) else { return true }
        guard let secondNumber = Double(String(numbersArray.last ?? "0")) else { return true }

        //format numbers and turn them back to string
        let firstFormattedNumber = formatter.string(for: firstNumber) ?? ""
        let secondFormattedNumber = formatter.string(for: secondNumber) ?? ""

        //assign formatted numbers to a textField
        textField.text = completeString.contains(symbol) ? "\(firstFormattedNumber)\(symbol)\(secondFormattedNumber)" : "\(firstFormattedNumber)"
        
        return string == formatter.decimalSeparator
    }
}

