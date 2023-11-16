//
//  RegisterFirebaseManager.swift
//  WA8_11
//
//  Created by Yu Zou on 11/13/23.
//

import Foundation
import FirebaseAuth

extension RegisterViewController{
    
    func registerNewAccount(){
        //MARK: create a Firebase user with email and password...
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text{
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    let contact = Contact(name: name, email: email.lowercased()
)
                    self.setNameOfTheUserInFirebaseAuth(contact: contact)
                }else{
                    //MARK: there is a error creating the user...
                    print(error)
                }
            })
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(contact: Contact){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = contact.name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                // self.navigationController?.popViewController(animated: true)
                self.saveUserToFirestore(contact: contact)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    //MARK: Logic to add a contact to Firestore...
    func saveUserToFirestore(contact: Contact) {
        let data: [String: Any] = ["name": contact.name]
        
        db.collection("users").document(contact.email).setData(data) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
