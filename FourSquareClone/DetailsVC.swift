//
//  DetailsVC.swift
//  FourSquareClone
//
//  Created by StarChanger on 09/11/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import MapKit
import Parse

class DetailsVC: UIViewController {

    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var detailsPlaceName: UILabel!
    @IBOutlet weak var detailsPlaceType: UILabel!
    @IBOutlet weak var detailsPlaceAtmosphere: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    
    var selectedObjectID: String = ""
    var detailsLattitude = Double()
    var detailsLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("selectedObjectID = " + selectedObjectID)
        
        getDataFromParse()
    }
    
    fileprivate func getDataFromParse() {
        
        let query = PFQuery(className: "Places")
        //query.whereKey("ObjectID", contains: selectedObjectID)
        query.whereKey("objectId", equalTo: selectedObjectID)
        query.findObjectsInBackground { (objects, error) in // As only one object will be loaded, singular form is used.
            if error != nil {
                self.showAlert(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Unknown error when fetching details from the cloud")
            } else {
                
                if objects != nil {
                    if objects!.count > 0 {
                        
                        let placesObject = objects![0]
                        
                        if let placePictue = placesObject.value(forKey: "picture") as? PFFileObject {
                            placePictue.getDataInBackground { (fileData, error) in
                                if error != nil {
                                    self.showAlert(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Unknown error when fetching details from the cloud")
                                } else {
                                    if fileData != nil {
                                        self.detailsImage.image = UIImage(data: fileData!)
                                    }
                                }
                            }
                        }
                        
                        if let placeName = placesObject.value(forKey: "name") as? String {
                            self.detailsPlaceName.text = placeName
                        }
                        
                        if let placeType = placesObject.value(forKey: "type") as? String {
                            self.detailsPlaceType.text = placeType
                        }
                        
                        if let placeAtmosphere = placesObject.value(forKey: "atmosphere") as? String {
                            self.detailsPlaceAtmosphere.text = placeAtmosphere
                        }
                        
                        
                        
                        if let placeLattitude = placesObject.value(forKey: "lattitude") as? String {
                            if let placeLattitudeDouble = Double(placeLattitude) {
                                self.detailsLongitude = placeLattitudeDouble
                            }
                        }
                        
                        if let placeLongitude = placesObject.value(forKey: "longitude") as? String {
                            if let placeLongitudeDouble = Double(placeLongitude) {
                                self.detailsLongitude = placeLongitudeDouble
                            }
                        }
                        
                    }
                    
                }
            }
        }
    }
    
    func showAlert(alertTitle:String, alertMessage:String) {
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
