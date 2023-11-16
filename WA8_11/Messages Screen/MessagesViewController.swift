//
//  MessagesViewController.swift
//  WA8_11
//
//  Created by 李凱鈞 on 11/16/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MessagesViewController: UIViewController {

    let messagesScreen = MessagesView()
    var receiver: Contact!
    
    // use this listener to track whether any user is signed in.
    var handleAuth: AuthStateDidChangeListenerHandle?
    // a variable to keep an instance of the current signed-in Firebase user.
    var currentUser:FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    var messagesList = [Message]()
    
    override func loadView() {
        view = messagesScreen
    }
    
//    // a lifecycle method where you can handle the logic before the screen is loaded.
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
//        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
//
//            //MARK: the user is signed in...
//            // update the local currentUser instance with the signed-in user.
//            self.currentUser = user
//
//
//            
//            //MARK: Observe Firestore database to display the contacts list...
//            self.database.collection("users")
//                .document((self.currentUser?.email)!)
//            // we observe the "contacts" collection of the current user document. If anything is changed in that collection, the closure gets triggered and querySnapshot contains the updates.
//                .collection("contacts")
//                .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
//                    if let documents = querySnapshot?.documents{
//                        self.contactsList.removeAll()
//                        for document in documents{
//                            do{
//                                // parse the received document and decode that according to the Contact struct (which is Codable).
//                                let contact  = try document.data(as: Contact.self)
//                                self.contactsList.append(contact)
//                            }catch{
//                                print(error)
//                            }
//                        }
//                        // sort the contacts in the alphabetic order of names.
//                        self.contactsList.sort(by: {$0.name < $1.name})
//                        self.mainScreen.tableViewContacts.reloadData()
//                    }
//                })
//        }
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = receiver.name
        


        // Do any additional setup after loading the view.
    }
    
//    // another lifecycle method where you can handle the logic right before the screen disappears.
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // remove the listener from the app so that we do not run the listener infinitely.
//        Auth.auth().removeStateDidChangeListener(handleAuth!)
//    }


}
