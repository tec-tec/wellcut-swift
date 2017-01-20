//
//  MessageDetailViewController.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 20/01/2017.
//  Copyright © 2017 Ludovic Ollagnier. All rights reserved.
//

import UIKit
import MapKit

class MessageDetailViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var goThereButton: UIButton!
    
    var selectedRestaurant: Restaurant?
    private var placemark: MKPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    private func configureUI() {
        guard let resto = selectedRestaurant else { return }
        
        navigationItem.title = resto.name
//        addressLabel.text = resto.address
        
        CLGeocoder().geocodeAddressString(resto.address) { (marks, error) in
            
            guard let item = marks?.first else { return }
            self.placemark = MKPlacemark(placemark: item)
            self.mapView.addAnnotation(self.placemark!)
            self.goThereButton.isHidden = false
            
            self.mapView.setRegion(MKCoordinateRegion(center: self.placemark!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        }
    }

    @IBAction func goToRestaurant(_ sender: Any) {
        guard let place = placemark else { return }
        MKMapItem(placemark: place).openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDefault])
    }
}
