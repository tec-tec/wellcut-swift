//
//  ViewController.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 14/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum FormError: Error {
        case noText(textField: UITextField)
        case notEnoughtCharacters (textField: UITextField, minNumbersOfChar: Int)
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var styleTextField: UITextField!
    @IBOutlet var stylePicker: UIPickerView!
    
    var directory = Directory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylePicker.dataSource = self
        stylePicker.delegate = self
        styleTextField.inputView = stylePicker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func restaurantFromForm() throws -> Restaurant {
        
        guard let name = nameTextField.text else {
            throw FormError.noText(textField: nameTextField)
        }
        guard name.characters.count >= 2 else {
            throw FormError.notEnoughtCharacters(textField: nameTextField, minNumbersOfChar: 2)
        }
        guard let address = addressTextField.text else {
            throw FormError.noText(textField: addressTextField)
        }
        guard address.characters.count >= 2 else {
            throw FormError.notEnoughtCharacters(textField: addressTextField, minNumbersOfChar: 2)
        }
        
        let resto = Restaurant(name: name, address: address)
        return resto
    }

    @IBAction func cancel(_ sender: Any) {
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        nameTextField.backgroundColor = UIColor.white
        addressTextField.backgroundColor = UIColor.white
        
        do {
            let resto = try restaurantFromForm()
            directory.add(resto)
        } catch FormError.noText(let textField) {
            textField.backgroundColor = UIColor.wellcutYellow
        } catch FormError.notEnoughtCharacters (let textField, let minNumbersOfChar){
            textField.backgroundColor = UIColor.wellcutYellow
            textField.shake()

            print("\(minNumbersOfChar)")
        } catch {
            
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Restaurant.Style.allStyles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Restaurant.Style.allStyles[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        styleTextField.text = Restaurant.Style.allStyles[row].rawValue
    }
}
