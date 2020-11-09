//
//  DetailsVC.swift
//  FourSquareClone
//
//  Created by StarChanger on 09/11/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import MapKit

class DetailsVC: UIViewController {

    @IBOutlet weak var detailsImage: UIImageView!
    
    @IBOutlet weak var detailsPlaceName: UILabel!
    
    @IBOutlet weak var detailsPlaceType: UILabel!
    
    @IBOutlet weak var detailsPlaceAtmosphere: UILabel!
    
    @IBOutlet weak var detailsMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
