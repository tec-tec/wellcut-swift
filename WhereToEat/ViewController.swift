//
//  ViewController.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 14/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    enum FormError: Error {
        case noText(textField: UITextField)
        case notEnoughtCharacters (textField: UITextField, minNumbersOfChar: Int)
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var styleTextField: UITextField!
    @IBOutlet var stylePicker: UIPickerView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var gradeSlider: UISlider!
    @IBOutlet weak var alreadyVisitedSwitch: UISwitch!
    @IBOutlet weak var noteStackView: UIStackView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var lastVisitDateButton: UIButton!
    @IBOutlet weak var lastVisitStackView: UIStackView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var directory = Directory.shared
    private var lastVisit: Date?
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    lazy private var locationManager = CLLocationManager()
    fileprivate var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylePicker.dataSource = self
        stylePicker.delegate = self
        styleTextField.inputView = stylePicker
        datePicker.maximumDate = Date()
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
        
        var resto = Restaurant(name: name, address: address, lastVisit: lastVisit)
        if alreadyVisitedSwitch.isOn {
            resto.grade = gradeSlider.value
        }
        
        if let coord = location {
            resto.latitude = coord.latitude
            resto.longitude = coord.longitude
        }
        
        return resto
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        nameTextField.backgroundColor = UIColor.white
        addressTextField.backgroundColor = UIColor.white
        
        do {
            let resto = try restaurantFromForm()
            directory.add(resto)
            dismiss(animated: true, completion: nil)
        } catch FormError.noText(let textField) {
            textField.backgroundColor = UIColor.wellcutYellow
        } catch FormError.notEnoughtCharacters (let textField, let minNumbersOfChar){
            textField.backgroundColor = UIColor.wellcutYellow
            textField.shake()

            print("\(minNumbersOfChar)")
        } catch {
            
        }
    }
    
    @IBAction func noteValueChanged(_ sender: UISlider) {
        let intNote = Int(sender.value)
        sender.value = Float(intNote)
        noteLabel.text = "\(intNote)"
    }
    
    @IBAction func alreadyVisitedSwitchValueChanged(_ sender: UISwitch) {
        noteStackView.isHidden = !sender.isOn
        lastVisitStackView.isHidden = !sender.isOn
    }
    
    @IBAction func toggleDatePicker(_ sender: UIButton) {
        datePicker.isHidden = !datePicker.isHidden
    }
    
    @IBAction func lastVisitDateChanged(_ sender: UIDatePicker) {
        lastVisit = sender.date
        let dateString = dateFormatter.string(from: lastVisit!)
        lastVisitDateButton.setTitle(dateString, for: .normal)
    }
    
    @IBAction func scrollViewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(false)
    }
    
    @IBAction func requestCurrentAddress(_ sender: Any) {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("Can't use location")
        default:
            break
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        loader.startAnimating()
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

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        loader.stopAnimating()
        guard let lastPosition = locations.last else { return }
        self.location = lastPosition.coordinate
        CLGeocoder().reverseGeocodeLocation(lastPosition) { (placemarks, error) in
            guard error == nil, let place = placemarks?.first else { return }
            self.addressTextField.text = (place.subThoroughfare ?? "") + " " + (place.thoroughfare ?? "") + ", " + (place.locality ?? "")
            print(place)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        loader.stopAnimating()
    }
}
