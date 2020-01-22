//
//  GetDataViewController.swift
//  RESTfulApp
//
//  Created by Ciaran Corrigan on 06/01/2020.
//  Copyright © 2020 Ciaran Corrigan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GetDataViewController: UIViewController {
    
    @IBOutlet weak var serverAddressLabel: UILabel!
    @IBOutlet weak var serverAddress: UITextField!
    @IBOutlet weak var stubSwitch: UISwitch!
    @IBOutlet weak var customerIDInput: UITextField!
    @IBOutlet weak var customertIDLabel: UILabel!
    @IBOutlet weak var findButton: UIButton!
    
    let urlCreator = URLCreator()
    
    //Should be set to true if unable to connect to a Jade DB - e.g. REST app isn't running
    var useStub : Bool = false
    var myCustomer : Customer? = nil
    var allCustomers : [Customer]? = nil
    
    @IBAction func findCustomerPressed(_ sender: UIButton) {
        if customerIDInput.text == "" && !useStub {
            let ac = UIAlertController(title: "Enter a customer ID", message: "No customer ID entered", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            getCustomer(url: urlCreator.createURL(id: customerIDInput!.text!))
        }
    }
    
    @IBAction func viewAllCustomersPressed(_ sender: Any) {
        
        getAllCustomers()
        
    }
    
    @IBAction func stubSwitchValueChanged(_ sender: UISwitch) {
        useStub = sender.isOn
        serverAddress.isHidden = useStub
        serverAddressLabel.isHidden = useStub
        customerIDInput.isHidden = useStub
        customertIDLabel.isHidden = useStub
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //The below allows the keyboard to be dismissed by tapping anywhere else
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(settingsTapped))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier{
        case "goToCustomer":
            let customerVC = segue.destination as! CustomerTableViewController
            if useStub {
                customerVC.myCustomer = Customer(name: "Customer Stub", id: "1", addressFirstLine: "99 Stub Street")
            } else {
                customerVC.myCustomer = Customer(name: myCustomer!.name, id: myCustomer!.id, addressFirstLine: myCustomer!.addressFirstLine)
            }
            
        case "goToAllCustomers":
            
            print("fuck you")
            
            let allCustomersVC = segue.destination as! AllCustomersTableViewController
            if useStub {
                
            } else {
                allCustomersVC.allCustomers = allCustomers
            }
            
        default:
            print("No segue exists for what is being done")
            return
        }
    }
    
    func getCustomer(url: String){
        if !useStub {
            Alamofire.request(url, method: .get).responseJSON{ response in
                if response.result.isSuccess {
                    self.setCustomerDataValues(response)
                    self.performSegue(withIdentifier: "goToCustomer", sender: self)
                } else {
                    print("Error \(String(describing: response.result.error))")
                    self.createOKAlertController(title: "Error", message: "Could not get customer details. Check connection URL")
                }
            }
        } else {
            //use stub data
            performSegue(withIdentifier: "goToCustomer", sender: self)
        }
    }
    
    func getAllCustomers(){
        let url = "https://a1ecf0f1.ngrok.io/RestfulJade/jadehttp.dll/AllCustomers/?RestService"
        
        if !useStub {
            Alamofire.request(url, method: .get).responseJSON{ response in
                if response.result.isSuccess {
                    
                    //parse JSON response into a [Customer] array
                    print(response)
                    
                    //self.performSegue(withIdentifier: "goToAllCustomers", sender: self)
                } else {
                    print("Error \(String(describing: response.result.error))")
                    self.createOKAlertController(title: "Error", message: "Could not get customer details. Check connection URL")
                }
            }
        } else {
            //user stub data
        }
    }

    func setCustomerDataValues(_ response: DataResponse<Any>) {
        
        let customerJSON : JSON = JSON(response.result.value!)
        let customerName = customerJSON["name"].stringValue
        let customerID = customerJSON["id"].stringValue
        let customerAddress = customerJSON["addressFirstLine"].stringValue
        
        myCustomer = Customer(name: customerName, id: customerID, addressFirstLine: customerAddress)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func settingsTapped(){
        let ac = UIAlertController(title: "Not yet implemented", message: "The settings screen has not yet been implemented", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    func createOKAlertController(title : String, message : String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
}
