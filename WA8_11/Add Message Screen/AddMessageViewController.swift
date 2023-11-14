//
//  AddMessageViewController.swift
//  WA8_11
//
//  Created by Yu Zou on 11/13/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddMessageViewController: UIViewController {
    
    var currentUser:FirebaseAuth.User?
    
    let addMessageScreen = AddMessageView()
    
    let database = Firestore.firestore()
    
    let childProgressView = ProgressSpinnerViewController()

    override func loadView() {
        view = addMessageScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Add a New Message"
        
    }
    
    //MARK: on add button tapped....
 
    

}
