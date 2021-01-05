//
//  MapVC.swift
//  FourSquareClone
//
//  Created by StarChanger on 24/10/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goToLocationsVC))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonTapped))
        
        let placeModel = PlaceModel.sharedInstance
        print("place name is " + placeModel.placeName)
        print("place atmosphere is " + placeModel.placeAtmosphere)
        print("place type is " + placeModel.placeType)
            
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
