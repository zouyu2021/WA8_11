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
    let currentUser = Auth.auth().currentUser
    
    let database = Firestore.firestore()
    
    var messagesList = [Message]()
    
    override func loadView() {
        view = messagesScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check if the receiver is set
        guard let receiver = receiver, let currentUserEmail = Auth.auth().currentUser?.email else {
            print("Receiver or current user is not set")
            return
        }
        
        // Check if a chat already exists
        checkForExistingChat(with: receiver, currentUserEmail: currentUserEmail) {
            // Code here will run after checkForExistingChat completes
            // For example, you can call another function here
            guard let chatID = self.currentChatID else {
                print("Chat ID is not available")
                return
            }
            // Fetch messages for the current chat
            self.fetchAllMessages(chatID: chatID)
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = receiver.name
        
        // Set up button action
        messagesScreen.buttonPost.addTarget(self, action: #selector(postMessage), for: .touchUpInside)
        //MARK: patching table view delegate and date source.
        messagesScreen.tableViewMessages.delegate = self
        messagesScreen.tableViewMessages.dataSource = self
        //MARK: removing the separator line.
        messagesScreen.tableViewMessages.separatorStyle = .none
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }

    
    private func checkForExistingChat(with receiver: Contact, currentUserEmail: String, completion: @escaping () -> Void) {
        database.collection("users").document(currentUserEmail).collection("chats")
            .whereField("receiverEmail", isEqualTo: receiver.email)
            .getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    print("Error checking for existing chat: \(error)")
                    return
                    completion()
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
                completion()
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
        
        // Check if the currentUser's name is available
        guard let currentUserName = Auth.auth().currentUser?.displayName else {
            print("Current user's name is nil")
            return
        }
        print("Sender Name: \(currentUserName)")
        
        // get messages collection
        let messageCollection = database.collection("chats").document(chatID).collection("messages")
        // create a message object
        let newMessage = Message(senderEmail: currentUserEmail, senderName: currentUserName, text: messageText, timestamp: Date())
        do{
            // add message
            try messageCollection.addDocument(from: newMessage, completion: {(error) in
                if error == nil{
                    print("Message saved successfully")
                    // Clear text field after sending
                    self.messagesScreen.textViewNote.text = ""
                }
            })
        }catch{
            print("Error saving message: \(error)")
        }
        // add to messagesList
        self.messagesList.append(newMessage)
    }
    
    private func fetchAllMessages(chatID: String){
        self.database.collection("chats").document(chatID).collection("messages")
                    .order(by: "timestamp", descending: false)  // Assuming you want to order by timestamp
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let error = error {
                            print("Error fetching messages: \(error)")
                            return
                        }
                        
                        guard let documents = querySnapshot?.documents else {
                            print("No messages found for chat ID: \(chatID)")
                            return
                        }
                        self.messagesList.removeAll()
                        
                        for document in documents {
                            do {
                                let message = try document.data(as: Message.self)
                                self.messagesList.append(message)
//                                print("Message retrieved: \(message)")
                            } catch {
                                print("Error decoding message: \(error)")
                            }
                        }
                        
                        self.messagesScreen.tableViewMessages.reloadData()
                        self.scrollToBottom()
        })
    }

    func scrollToBottom() {
        let numberOfSections = messagesScreen.tableViewMessages.numberOfSections
        let numberOfRows = messagesScreen.tableViewMessages.numberOfRows(inSection: numberOfSections - 1)
        if numberOfRows > 0 {
            let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfSections - 1)
            messagesScreen.tableViewMessages.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }

}
