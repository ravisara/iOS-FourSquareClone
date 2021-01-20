//
//  MapVC.swift
//  FourSquareClone
//
//  Created by StarChanger on 24/10/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import MapKit

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
            
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //manager.stopUpdatingLocation() // Should I use this manager or should I use locationsManager defined above ? Found through experimentation that both work.
        locationsManager.stopUpdatingLocation()
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
        print("Save button tapped")
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
