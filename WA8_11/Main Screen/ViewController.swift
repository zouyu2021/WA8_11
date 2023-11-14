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
    
    var messagesList = [Messages]()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
        
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
                self.mainScreen.floatingButtonAddMessage.isEnabled = false
                self.mainScreen.floatingButtonAddMessage.isHidden = true
                //MARK: Reset tableView.
                self.messagesList.removeAll()
                self.mainScreen.tableViewMessages.reloadData()
                
                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
            }else{
                //MARK: the user is signed in.
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome\(user?.displayName ?? "Anonymous")!"
                self.mainScreen.floatingButtonAddMessage.isEnabled = true
                self.mainScreen.floatingButtonAddMessage.isHidden = false
                
                //MARK: Logout bar button...
                self.setupRightBarButton(isLoggedin: true)
                
                //MARK: Observe Firestore database to display the contacts list...
                self.database.collection("users")
                    .document((self.currentUser?.email)!)
                    .collection("contacts")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            self.messagesList.removeAll()
                            for document in documents{
                                do{
                                    let message  = try document.data(as: Messages.self)
                                    self.messagesList.append(message)
                                }catch{
                                    print(error)
                                }
                            }
                            self.messagesList.sort(by: {$0.name < $1.name})
                            self.mainScreen.tableViewMessages.reloadData()
                        }
                    })
               
            }
        }
    }
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Messages"
        
        //MARK: Make the titles look large.
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: put the floating button above all views.
        view.bringSubviewToFront(mainScreen.floatingButtonAddMessage)
        
        //MARK: patching table view delegate and date source.
        mainScreen.tableViewMessages.delegate = self
        mainScreen.tableViewMessages.dataSource = self
        
        //MARK: removing the separator line.
        mainScreen.tableViewMessages.separatorStyle = .none
        
        //MARK: tapping the floating add contact button...
        mainScreen.floatingButtonAddMessage.addTarget(self, action: #selector(addMessageButtonTapped), for: .touchUpInside)
    }
       
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    @objc func addMessageButtonTapped(){
        let addMessageController = AddMessageViewController()
        addMessageController.currentUser = self.currentUser
        navigationController?.pushViewController(addMessageController, animated: true)
    }

}
