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
            }else{
                //MARK: the user is signed in.
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome\(user?.displayName ?? "Anonymous")!"
                self.mainScreen.floatingButtonAddMessage.isEnabled = true
                self.mainScreen.floatingButtonAddMessage.isHidden = false
                
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
        
        //MARK: tapping the floating add
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
}

