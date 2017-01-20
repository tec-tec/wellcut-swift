//
//  RestoTableViewDataProvider.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 19/01/2017.
//  Copyright © 2017 Ludovic Ollagnier. All rights reserved.
//

import UIKit

class RestoTableViewDataProvider: NSObject, UITableViewDataSource {

    let directory = Directory.shared
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directory.allRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        switch indexPath.row {
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "restoCell", for: indexPath)
            if indexPath.row == 10 {
                cell.backgroundColor = UIColor.red
            } else {
                cell.backgroundColor = UIColor.white
            }
            cell.textLabel?.text = directory.allRestaurants[indexPath.row].name
            cell.detailTextLabel?.text = directory.allRestaurants[indexPath.row].address
        }
        
        return cell
    }
    
    // MARK: - Table view cell deletion
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let currentResto = directory.allRestaurants[indexPath.row]
            directory.remove(currentResto)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }

}
