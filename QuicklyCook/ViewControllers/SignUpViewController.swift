//
//  SignUpViewController.swift
//  QuicklyCook
//
//  Created by Renzo Alessandro on 11/3/19.
//  Copyright © 2019 Renzo Alessandro. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        errorLabel.alpha = 0 
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func validatefields() -> String?{
        if firstnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Por favor rellenar todos los campos."
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false{
            return "Asegurese de que su contraseña tenga al menos 8 caracteres, contenga un carácter especial y un numero."
        }
        
        
        return nil
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        //Validacion de entradas
        let error = validatefields()
        if error != nil {
            showError(error!)
        }
        else{
            let firstName = firstnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            //creacion del usuario
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil{
                    self.showError("Error al Crear Usuario.")
                }
                else{
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName,"lastname":lastName,"uid":result!.user.uid]){ (error) in
                        
                        if error != nil{
                            self.showError("Error al guardar losdatos del usuario.")
                        }
                    }
                    //transicion a homepage
                    
                    self.transitionToHome()
                }
            }
        }
    }
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)as?HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
