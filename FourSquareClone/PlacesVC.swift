//
//  placesVC.swift
//  FourSquareClone
//
//  Created by StarChanger on 11/10/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import Parse

class PlacesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: nil, action: #selector(plusButtonPressed))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(plusButtonPressed))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
    
    }
    
    @objc func plusButtonPressed() {
        performSegue(withIdentifier: "toLocationsVC", sender: nil)
    }
    
    @objc func logoutButtonClicked() {
        print("Log out button clicked")
        PFUser.logOutInBackground { (error) in
            if (error != nil) {
                let alertController = UIAlertController(title: "Error", message: "Error encountered logging out", preferredStyle: UIAlertController.Style.alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "toSignUpInVC", sender: self)
            }
        }
        
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
