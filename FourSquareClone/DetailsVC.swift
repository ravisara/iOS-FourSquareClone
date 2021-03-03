//
//  DetailsVC.swift
//  FourSquareClone
//
//  Created by StarChanger on 09/11/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {
    
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
        
        detailsMapView.delegate = self
        
        // Do any additional setup after loading the view.
        print("selectedObjectID = " + selectedObjectID)
        
        getDataFromParse()
        
    }
    
    fileprivate func getDataFromParse() {
        
        let query = PFQuery(className: "Places")
        
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
                                self.detailsLattitude = placeLattitudeDouble
                            }
                        }
                        
                        if let placeLongitude = placesObject.value(forKey: "longitude") as? String {
                            if let placeLongitudeDouble = Double(placeLongitude) {
                                self.detailsLongitude = placeLongitudeDouble
                            }
                        }
                        
                        let location = CLLocationCoordinate2D(latitude: self.detailsLattitude, longitude: self.detailsLongitude)
                        let spanForMap = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035) // I think the course instructor uses these values normally.
                        
                        let regionToShow = MKCoordinateRegion(center: location, span: spanForMap)
                        self.detailsMapView.region = regionToShow
                        
                        // Add the annotation
                        let annotationToShow = MKPointAnnotation()
                        annotationToShow.coordinate = location
                        annotationToShow.title = self.detailsPlaceName.text
                        annotationToShow.subtitle = self.detailsPlaceType.text
                        
                        self.detailsMapView.addAnnotation(annotationToShow)
                        
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
    
    func mapView(_ mapView: MKMapView, viewFor currentlyConsideredAnnotation: MKAnnotation) -> MKAnnotationView? {
        
        if currentlyConsideredAnnotation is MKUserLocation { // as we don't want to touch the annotation that shows the users current location
            return nil
        }
        
        let reuseId = "pinAnnotationOfPlace"
        
        var pinView = detailsMapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: currentlyConsideredAnnotation, reuseIdentifier: reuseId )
            pinView?.canShowCallout = true
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView!.annotation = currentlyConsideredAnnotation
        }
        
        return pinView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if detailsLattitude != 0.0 && detailsLongitude != 0.0 {
            
            let requestLocation = CLLocation(latitude: detailsLattitude, longitude: detailsLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                
                if error != nil {
                    
                } else {
                    if let placeMarksForSavedLocation = placemarks {
                        
                        if placeMarksForSavedLocation.count > 0 {
                            
                            let placeMark = MKPlacemark(placemark: placeMarksForSavedLocation[0])
                            let mapItem = MKMapItem(placemark: placeMark)
                            mapItem.name = self.detailsPlaceName.text
                            
                            let theLaunchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                            mapItem.openInMaps(launchOptions: theLaunchOptions)
                        }
                        
                    }
                }
                
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
