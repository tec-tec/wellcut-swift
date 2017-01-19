//
//  RestoDetailsViewController.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 15/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import UIKit
import MapKit

class RestoDetailsViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var displayedRestaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let resto = displayedRestaurant else {
            fatalError("No restaurant!")
        }
        
        title = resto.name
        addressLabel.text = resto.address
        
        let prefs = UserDefaults.standard
        prefs.set(displayedRestaurant?.name, forKey: Constants.UserDefaultsKeys.lastResto)
        displayedRestaurant?.saveToDisk(data: Data())
        
        if let lat = resto.latitude, let long = resto.longitude {
            let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = resto.name
            mapView.addAnnotation(annotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        
        let shareVC = UIActivityViewController(activityItems: ["Some data to share", "This can be images or videos"], applicationActivities: nil)
        shareVC.popoverPresentationController?.barButtonItem = sender
        shareVC.completionWithItemsHandler = { (activity, completed, returns, error) in
            //Do what relevant if completed or cancelled, or in case of error
        }
        present(shareVC, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
