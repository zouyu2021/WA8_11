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
        //MARK: display the progress indicator...
        showActivityIndicator()
        //MARK: create a Firebase user with email and password...
        if let name            = registerView.textFieldName.text,
           let email           = registerView.textFieldEmail.text,
           let password        = registerView.textFieldPassword.text,
           let confirmPassword = registerView.textFieldConfirmPassword.text{
            if password != confirmPassword{
                self.hideActivityIndicator()
                self.showPasswordInconsistentAlert()
                return
            }
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
                self.saveUserToFirestore(contact: contact)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    //MARK: Logic to add a contact to Firestore...
    func saveUserToFirestore(contact: Contact) {
        
        // get a reference to the email document
        let emailDocument = db.collection("users").document(contact.email)
        let userData: [String: String] = ["name": contact.name]

        do {
            // add user name as a field to the user email, which is the docuemnt ID
            try emailDocument.setData(from: userData, completion: { (error) in
                if let error = error {
                    print("Error setting user data: \(error.localizedDescription)")
                } else {
                    print("User email data successfully written!")
                }
            })
        } catch {
            print("Error encoding user data: \(error.localizedDescription)")
        }
        
        
        let dummyData: [String: String] = ["email": "This is dummy"]
        do {
            // create a collection "chat" with dummy data
            try emailDocument.collection("chats").document("Dummy ID").setData(from: dummyData, completion: {(error) in
                if let error = error {
                    print("Error setting contacts data: \(error.localizedDescription)")
                } else {
                    print("User and contacts data successfully written!")
                    //MARK: hide the progress indicator...
                    self.hideActivityIndicator()
                    // go back to the main screen
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } catch {
            print("Error encoding contacts data: \(error.localizedDescription)")
        }
    }
    
}
