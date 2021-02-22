//
//  MapVC.swift
//  FourSquareClone
//
//  Created by StarChanger on 24/10/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//<#T##(() -> Void)?##(() -> Void)?##() -> Void#>

//import UIKit trying to see if I can get away with not importing this(21-Jan-2021)
// TODO location manager updates not working in the way I want, table view is not laoding data newly added.
import MapKit
import Parse

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationsManager = CLLocationManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goToLocationsVC))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonTapped))
        
        let placeModel = PlaceModel.sharedInstance
        print("place name is " + placeModel.placeName)
        print("place atmosphere is " + placeModel.placeAtmosphere)
        print("place type is " + placeModel.placeType)
        
        mapView.delegate = self
        locationsManager.delegate = self
        locationsManager.desiredAccuracy = kCLLocationAccuracyBest
        locationsManager.requestWhenInUseAuthorization()
        locationsManager.startUpdatingLocation()
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(gestureRecognizer:)))
        longPressGestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(longPressGestureRecognizer)
        
    }
    
    @objc func longPressed(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if (gestureRecognizer.state == UIGestureRecognizer.State.began) { // not clear what exactly this is for TODO
            
            let touches = gestureRecognizer.location(in: self.view)
            let coordinatesOfTheTouchPointInMapView = mapView.convert(touches, toCoordinateFrom: self.view)
            
            let annotation = MKPointAnnotation()
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            annotation.coordinate = coordinatesOfTheTouchPointInMapView
                        
            PlaceModel.sharedInstance.sharedLatitude = String(coordinatesOfTheTouchPointInMapView.latitude)
            PlaceModel.sharedInstance.sharedLongitude = String(coordinatesOfTheTouchPointInMapView.longitude)
            
            mapView.addAnnotation(annotation)
            
        }
   
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //manager.stopUpdatingLocation() // Should I use this manager or should I use locationsManager defined above ? Found through experimentation that both work.
        locationsManager.stopUpdatingLocation() // this is proving problamatic though as when the location is not changed from the simulator, the mapview no longer updates(although it does so initially)
        let currentUserLocation = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let spanToUseForMap = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: currentUserLocation, span: spanToUseForMap)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    @objc func goToLocationsVC() {
        print("about to try taking to LocationsVC")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        
        let object = PFObject(className: "Places")
        let model = PlaceModel.sharedInstance
        
        //object.add(PlaceModel.sharedInstance.placeName, forKey: "name") This created an array although I thought this was similar to using the syntax below! Good lesson learned.
        object["name"] = model.placeName
        object["type"] = model.placeType
        object["atmosphere"] = model.placeAtmosphere
        object["lattitude"] = model.sharedLatitude
        object["longitude"] = model.sharedLongitude
                
        if let fileData = PlaceModel.sharedInstance.placePicture.jpegData(compressionQuality: 0.5) {
            let fileObject = PFFileObject(name: "image.jpg", data: fileData)
            object["picture"] = fileObject
        }
     
        object.saveInBackground { (success, error) in
            if (error != nil) {
                self.showAllert(alertTitle: "Error saving to Parse server!", alertMessage: error?.localizedDescription ?? "Unknown error" )
            } else {
                self.showAllert(alertTitle: "Success!", alertMessage: "Location successfully saved to Parse")
                self.performSegue(withIdentifier: "fromMapVCtoPlacesVC", sender: nil)
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
