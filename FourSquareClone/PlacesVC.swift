//
//  placesVC.swift
//  FourSquareClone
//
//  Created by StarChanger on 11/10/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var objectIDArray = [String]()
    var placeNameArray =  [String]()
    var selectedObjectID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
      
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(plusButtonPressed))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromParseServer()
    
    }
    
    
    func getDataFromParseServer() {
        let query = PFQuery(className: "Places")
        
        query.findObjectsInBackground { (objects, error) in
            if (error != nil) {
                self.showAllert(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Unknown error reading from the cloud")
            } else {
                if (objects != nil) {
                    
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    self.objectIDArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let name = object.object(forKey: "name") as? String {
                            if let objectID = object.objectId {
                                self.objectIDArray.append(objectID)
                                self.placeNameArray.append(name)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetailsVC") {
            let detailsVC = segue.destination as! DetailsVC
            detailsVC.selectedObjectID = selectedObjectID
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedObjectID = objectIDArray[indexPath.row]
        performSegue(withIdentifier: "showDetailsVC", sender: nil)
    }
    
    @objc func plusButtonPressed() {
        performSegue(withIdentifier: "toLocationsVC", sender: nil)
    }
    
    @objc func logoutButtonClicked() {
        
        print("Log out button clicked")
        PFUser.logOutInBackground { (error) in
            if (error != nil) {
                self.showAllert(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error logging out")
            } else {
                self.performSegue(withIdentifier: "toSignUpInVC", sender: self)
            }
        }
        
    }
    
    func showAllert(alertTitle:String, alertMessage:String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage , preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
