//
//  ViewController.swift
//  WA8_11
//
//  Created by Yu Zou on 11/13/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    
    var contactList = [Contact]()
        
    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in.
                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in to see the messages!"
                //MARK: Reset tableView.
                self.contactList.removeAll()
                self.mainScreen.tableViewMessages.reloadData()
                
                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
            }else{
                //MARK: the user is signed in.
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                
                //MARK: Logout bar button...
                self.setupRightBarButton(isLoggedin: true)
                
                //MARK: Observe Firestore database to display the contacts list...
                // all users are friends with other, add all users except the signed in user
                self.database.collection("users")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            self.contactList.removeAll()
                            for document in documents{
                                do{
                                    // Access the "name" field
                                    let name = try document.get("name") as? String ?? ""
                                    // Get the document ID (assuming it's the email)
                                    let email = document.documentID
                                    // If the email is same as current user's email
                                    if email == self.currentUser?.email{
                                        continue
                                    }
                                    
                                    let contact = Contact(name: name, email: email)
                                    self.contactList.append(contact)
                                }catch{
                                    print(error)
                                }
                            }
                            self.contactList.sort(by: {$0.name < $1.name})
                            self.mainScreen.tableViewMessages.reloadData()
                        }
                    })
            }
        }
    }
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Contacts"
        
        //MARK: patching table view delegate and date source.
        mainScreen.tableViewMessages.delegate = self
        mainScreen.tableViewMessages.dataSource = self
        
        //MARK: removing the separator line.
        mainScreen.tableViewMessages.separatorStyle = .none
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }

    func getChatDetails(contact: Contact){
        let messagesViewController = MessagesViewController()
        messagesViewController.receiver = contact
        navigationController?.pushViewController(messagesViewController, animated: true)
    }
}
