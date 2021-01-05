//
//  PlacesModel.swift
//  FourSquareClone
//
//  Created by StarChanger on 08/12/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import Foundation
import UIKit

// Singleton Class used to pass info from one View Controller to another.
class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placePicture = UIImage()
    
    private init() {} // As this is a Singleton
    
}
