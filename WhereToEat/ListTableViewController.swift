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
        let d = Directory.shared
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DidLoad")
        
        let notCenter = NotificationCenter.default        
        notCenter.addObserver(self, selector: #selector(reload), name: Notification.Name(Constants.NotificationNames.modelUpdated), object: nil)
        
//        weak var weakSelf = self
//        notCenter.addObserver(forName: Notification.Name("modelUpdated"), object: nil, queue: nil) { (note) in
//            weakSelf?.tableView.reloadData()
//        }
        
        let prefs = UserDefaults.standard
        guard let lastResto = prefs.string(forKey: Constants.UserDefaultsKeys.lastResto) else { return }
        print(lastResto)
    }
    
    func reload() {
        tableView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showForm" {
            
        } else if segue.identifier == "showDetails" {
            guard let destination = segue.destination as? RestoDetailsViewController else { return }
            guard let cell = sender as? UITableViewCell else { return }
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let resto = directory.allRestaurants[indexPath.row]
            
            destination.displayedRestaurant = resto
        }
    }
}
