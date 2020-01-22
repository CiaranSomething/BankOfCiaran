//
//  CustomerTableViewController.swift
//  RESTfulApp
//
//  Created by Ciaran Corrigan on 13/01/2020.
//  Copyright © 2020 Ciaran Corrigan. All rights reserved.
//

import UIKit

class CustomerTableViewController: UITableViewController {
    
    var myCustomer : Customer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as! CustomerDetailsViewController
        detailsVC.myCustomer = myCustomer
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.detailTextLabel?.highlightedTextColor = .darkGray
        
        switch indexPath.item {
        case 0:
            cell.textLabel?.text = "Name"
            cell.detailTextLabel?.text = myCustomer?.name
            
        case 1:
            cell.textLabel?.text = "First Line of Address"
            cell.detailTextLabel?.text = myCustomer?.addressFirstLine
            
        case 2:
            cell.textLabel?.text = "Edit"
            cell.textLabel?.textColor = .blue
            cell.selectionStyle = .default
            
        default:
            cell.textLabel?.text = "other"
        }
        
        return cell
    }

    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 2 {
                
            performSegue(withIdentifier: "editDetails", sender: self)
            
//            let ac = UIAlertController(title: "Not implemented", message: "Can't edit details yet", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
            
        }
    }

}
