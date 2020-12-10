//
//  CameraViewController.swift
//  QuicklyCook
//
//  Created by Renzo Alessandro on 11/27/19.
//  Copyright © 2019 Renzo Alessandro. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var TakePhoto: UIButton!
    @IBOutlet weak var PhotoLibrary: UIButton!
    @IBOutlet weak var ImageDisplay: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //ACION DE FOTOS Y LIBRERIA DE FOTOS
    @IBAction func PhotoLibraryAction(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker,animated: true, completion: nil)
    }
    
    @IBAction func TakePhotoAction(_ sender: Any) {
         if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ImageDisplay.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage; dismiss(animated: true, completion: nil)
    }

}
