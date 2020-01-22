//
//  CustomerDetailsViewController.swift
//  RESTfulApp
//
//  Created by Ciaran Corrigan on 16/01/2020.
//  Copyright © 2020 Ciaran Corrigan. All rights reserved.
//

import UIKit
import Alamofire

class CustomerDetailsViewController: UIViewController {

    var myCustomer : Customer?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if myCustomer == nil {
            
            //send POST request to create new customer
            let postUrl = "https://e8a161dc.ngrok.io/RestfulJade/Jadehttp.dll/Customer/\(nameTextField.text!)/\(addressTextField.text!)?RestService"
            
            //Alamofire.request(url).responseJSON{ response in
            Alamofire.request(postUrl, method: .post).responseJSON{ response in
                if response.result.isSuccess {
                    
                } else {
                    print("Error \(String(describing: response.result.error))")
                }
            }
            
        } else {
            //send PUT request to update existing customer
            
            let newName = nameTextField.text
            let newAddress = addressTextField.text
            
            let ac = UIAlertController(title: "Not yet implemented", message: "PUT functionality not implemented", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if myCustomer == nil {
            nameTextField.textColor = .gray
            addressTextField.textColor = .gray
        }
        
        //The below allows the keyboard to be dismissed by tapping anywhere else
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        nameTextField.text = myCustomer?.name ?? "Name"
        addressTextField.text = myCustomer?.addressFirstLine ?? "Address"
    }

    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

}
