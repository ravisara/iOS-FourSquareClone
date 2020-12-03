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
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        placePicture.addGestureRecognizer(gestureRecognizer)
        placePicture.isUserInteractionEnabled = true
        
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
        placePicture.image = info[(.originalImage)] as? UIImage // as sometings can wrong like the user not selecting an image - why optional casting is done.
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
