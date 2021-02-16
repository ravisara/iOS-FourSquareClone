//
//  DetailsVC.swift
//  FourSquareClone
//
//  Created by StarChanger on 09/11/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {

    @IBOutlet weak var detailsImage: UIImageView!
    
    @IBOutlet weak var detailsPlaceName: UILabel!
    
    @IBOutlet weak var detailsPlaceType: UILabel!
    
    @IBOutlet weak var detailsPlaceAtmosphere: UILabel!
    
    @IBOutlet weak var detailsMapView: MKMapView!
    
    var selectedObjectID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("selectedObjectID = " + selectedObjectID)
        
        let query = PFQuery(className: "Places")
        //query.whereKey("ObjectID", contains: selectedObjectID)
        query.whereKey("objectId", equalTo: selectedObjectID)
        query.findObjectsInBackground { (objects, error) in
            if (error != nil) {
                self.showAllert(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Unknown error when fetching details from the cloud")
            } else {
                print(objects)
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
