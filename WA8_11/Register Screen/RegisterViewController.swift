//
//  RegisterViewController.swift
//  WA8_11
//
//  Created by Yu Zou on 11/13/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    let registerView = RegisterView()
    
    let childProgressView = ProgressSpinnerViewController()
    
    let db = Firestore.firestore()
   
    override func loadView() {
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        registerView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
    }
    
    @objc func onRegisterTapped(){
        //MARK: creating a new user on Firebase...
        if registerView.textFieldPassword.text == registerView.textFieldPasswordConfirm.text {
            // Passwords match, proceed with registration logic
            registerNewAccount()
        } else {
            // Passwords do not match, show an alert
            showAlert()
        }
    }
    
    // Show an alert when passwords are inconsistent
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Passwords do not match. Please check your input.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        }
    
}
