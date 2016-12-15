//
//  ListTableViewController.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 15/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    var directory: Directory = {
        let d = Directory()
        for i in 0...10 {
            let r = Restaurant(name: "Resto \(i)", address: "Adresse \(i)")
            d.add(r)
        }
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directory.allRestaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell

        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "adCell", for: indexPath)
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "restoCell", for: indexPath)
            if indexPath.row == 10 {
                cell.backgroundColor = UIColor.red
            } else {
                cell.backgroundColor = UIColor.wellcutYellow
            }
            cell.textLabel?.text = directory.allRestaurants[indexPath.row].name
            cell.detailTextLabel?.text = directory.allRestaurants[indexPath.row].address
        }
        
        return cell
    }
    
    // MARK: - Table view cell deletion

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
