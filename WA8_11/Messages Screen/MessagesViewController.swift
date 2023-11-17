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
    
    var currentChatID: String?
    
    // use this listener to track whether any user is signed in.
    var handleAuth: AuthStateDidChangeListenerHandle?
    // a variable to keep an instance of the current signed-in Firebase user.
    var currentUser:FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    var messagesList = [Message]()
    
    override func loadView() {
        view = messagesScreen
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//
//        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
//        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
//            if user == nil{
//                //MARK: not signed in.
//
//            }else{
//                //MARK: the user is signed in.
//                self.currentUser = user
//
//                //MARK: Observe Firestore database to display the contacts list...
//                // all users are friends with other, add all users except the signed in user
//                self.database.collection("chats")
//                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
//                        if let documents = querySnapshot?.documents{
//                            self.messagesList.removeAll()
//                            for document in documents{
//                                do{
//                                    // Access the "name" field
//                                    let name = try document.get("name") as? String ?? ""
//                                    // Get the document ID (assuming it's the email)
//                                    let email = document.documentID
//                                    // If the email is same as current user's email
//                                    if email == self.currentUser?.email{
//                                        continue
//                                    }
//
//                                    let message = Message(senderName: sendername, textMessages: text, momentInTime: Date)
//                                    self.messagesList.append(message)
//                                }catch{
//                                    print(error)
//                                }
//                            }
//                            self.contactList.sort(by: {$0.name < $1.name})
//                            self.messagesScreen.tableViewMessages.reloadData()
//                        }
//                    })
//
//
//                //MARK: Observe Firestore database to display the contacts list...
//
//            }
//        }
//    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = receiver.name
        
        // Check if the receiver is set
        guard let receiver = receiver, let currentUserEmail = Auth.auth().currentUser?.email else {
            print("Receiver or current user is not set")
            return
        }
        
        // Check if a chat already exists
        checkForExistingChat(with: receiver, currentUserEmail: currentUserEmail)
        
        // Set up button action
        messagesScreen.buttonPost.addTarget(self, action: #selector(postMessage), for: .touchUpInside)

    }

    
    private func checkForExistingChat(with receiver: Contact, currentUserEmail: String) {
        database.collection("users").document(currentUserEmail).collection("chats")
            .whereField("receiverEmail", isEqualTo: receiver.email)
            .getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    print("Error checking for existing chat: \(error)")
                    return
                }

                if let documents = snapshot?.documents, !documents.isEmpty {
                    // Existing chat found, set the currentChatID
                    if let chatDocument = documents.first {
                        self?.currentChatID = chatDocument.documentID
                        print("Existing chat ID set: \(String(describing: self?.currentChatID))")
                    }
                } else {
                    // No existing chat, create a new one
                    self?.createChat(with: receiver, currentUserEmail: currentUserEmail)
                }
            }
    }


    private func createChat(with receiver: Contact, currentUserEmail: String) {
        let newChatID = database.collection("users").document(currentUserEmail).collection("chats").document().documentID

        let currentUserChatData: [String: Any] = ["receiverEmail": receiver.email]
        
        let receiverChatData: [String: Any] = ["receiverEmail": currentUserEmail]

        
        // Create chat document for the current user
        database.collection("users").document(currentUserEmail).collection("chats").document(newChatID).setData(currentUserChatData) { error in
            if let error = error {
                print("Error writing chat document for current user: \(error)")
            } else {
                print("Chat document for current user successfully written with ID: \(newChatID)")
            }
        }

        // Create corresponding chat document for the receiver
        database.collection("users").document(receiver.email).collection("chats").document(newChatID).setData(receiverChatData) { error in
            if let error = error {
                print("Error writing chat document for receiver: \(error)")
            } else {
                print("Chat document for receiver successfully written with ID: \(newChatID)")
            }
        }
        
        // Create the actual chat document in the 'chats' collection
        database.collection("chats").document(newChatID).setData(["participants": [currentUserEmail, receiver.email]])
        
        self.currentChatID = newChatID
        print("I am here", self.currentChatID)
    }
    
    
    @objc private func postMessage() {
        
        print("Post Message function")

            // Print the text from the textView
            print("Text from textView: \(String(describing: messagesScreen.textViewNote.text))")

            // Check if the message text is empty
            guard let messageText = messagesScreen.textViewNote.text, !messageText.isEmpty else {
                print("Message text is empty")
                return
            }

            // Check if the currentChatID is set
        guard let chatID = self.currentChatID else {
                print("Current chat ID is nil")
                return
            }
            print("Current Chat ID: \(chatID)")

            // Check if the currentUser's email is available
            guard let currentUserEmail = Auth.auth().currentUser?.email else {
                print("Current user's email is nil")
                return
            }
            print("Sender Email: \(currentUserEmail)")
//        guard let messageText = messagesScreen.textViewNote.text, !messageText.isEmpty,
//              let chatID = self.currentChatID,
//              let senderEmail = currentUser?.email else {
//            print("No text or chat ID or current user email")
//            return
//        }

        let newMessage = ["text": messageText, "senderEmail": currentUserEmail, "timestamp": FieldValue.serverTimestamp()] as [String : Any]
        let messageDocument = database.collection("chats").document(chatID).collection("messages").document()

        messageDocument.setData(newMessage) { error in
            if let error = error {
                print("Error saving message: \(error)")
            } else {
                print("Message saved successfully")
                self.messagesScreen.textViewNote.text = "" // Clear text field after sending
            }
        }
    }
    
    
//    // another lifecycle method where you can handle the logic right before the screen disappears.
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // remove the listener from the app so that we do not run the listener infinitely.
//        Auth.auth().removeStateDidChangeListener(handleAuth!)
//    }


}
