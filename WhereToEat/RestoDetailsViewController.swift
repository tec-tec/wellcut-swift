//
//  RestoDetailsViewController.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 15/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import UIKit

class RestoDetailsViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    var displayedRestaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.text = displayedRestaurant?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
