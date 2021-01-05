//
//  LocationsVC.swift
//  FourSquareClone
//
//  Created by StarChanger on 22/10/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit

class LocationsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeAtmosphere: UITextField!
    @IBOutlet weak var placePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyBoardDismissGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(keyBoardDismissGestureRecognizer)

        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        placePicture.addGestureRecognizer(gestureRecognizer)
        placePicture.isUserInteractionEnabled = true
        
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {

        guard (placeName.text != "" && placeType.text != "" && placeAtmosphere.text != "") else {
            
            showAlert(alertTitle: "Check all text fields have been filled.", alertMessage: "Make sure place name, place type and place atmosphere fields are not blank.")
            return
            
        }
        
        if let imageThatHasBeenSet = placePicture.image {
            let placeHolderImage = UIImage(named: "selectimage.png")
            if (imageThatHasBeenSet.isEqual(placeHolderImage)) {
                showAlert(alertTitle: "No image selected", alertMessage: "Make sure an image has been selected.")
            } else {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeName.text!
                placeModel.placeType = placeType.text!
                placeModel.placeAtmosphere = placeAtmosphere.text!
                placeModel.placePicture = imageThatHasBeenSet
                performSegue(withIdentifier: "toMapVC", sender: nil)
            }
        } else {
            
        }
        
    }
    
    func showAlert(alertTitle: String, alertMessage:String) {
        let alertController = UIAlertController(title: alertTitle , message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc
    func imageTapped() {
        
        let imageController = UIImagePickerController()
        imageController.allowsEditing = false
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        
        self.present(imageController, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        placePicture.image = info[(.originalImage)] as? UIImage // as sometings can go wrong like the user not selecting an image - why optional casting is done.
        self.dismiss(animated: true, completion: nil)
        
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
