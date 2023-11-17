//
//  MessagesView.swift
//  WA8_11
//
//  Created by 李凱鈞 on 11/16/23.
//

import UIKit

class MessagesView: UIView {
    
    var tableViewMessages: UITableView!
    
    var buttonPostView:UIView!
    var textViewNote:  UITextView!
    var buttonPost:    UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupTableViewDetails()
        setupButtonPostView()
        setupTextViewNote()
        setupButtonPost()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: the table view to show the list of notes...
    func setupTableViewDetails(){
        tableViewMessages = UITableView()
        tableViewMessages.register(SelfMessagesTableViewCell.self, forCellReuseIdentifier: Configs.tableViewSelfMessageID)
        tableViewMessages.register(FriendMessagesTableViewCell.self, forCellReuseIdentifier: Configs.tableViewFriendMessageID)
        tableViewMessages.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewMessages)
    }
    
    //MARK: the bottom add contact view....
    func setupButtonPostView(){
        buttonPostView = UIView()
        buttonPostView.backgroundColor = .white
        buttonPostView.layer.cornerRadius = 6
        buttonPostView.layer.shadowColor = UIColor.lightGray.cgColor
        buttonPostView.layer.shadowOffset = .zero
        buttonPostView.layer.shadowRadius = 4.0
        buttonPostView.layer.shadowOpacity = 0.7
        buttonPostView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonPostView)
    }
    
    func setupTextViewNote(){
        textViewNote = UITextView()
        textViewNote.font = UIFont.systemFont(ofSize: 24)
        textViewNote.textColor = UIColor.black
        textViewNote.backgroundColor = .systemGray5
        textViewNote.isEditable = true
        textViewNote.isScrollEnabled = true
        textViewNote.layer.borderWidth = 1.0
        textViewNote.layer.borderColor = UIColor.lightGray.cgColor
        textViewNote.autocapitalizationType = .none
        textViewNote.layer.cornerRadius = 5.0
        textViewNote.translatesAutoresizingMaskIntoConstraints = false
        buttonPostView.addSubview(textViewNote)
    }
    
    func setupButtonPost(){
        buttonPost = UIButton(type: .system)
        buttonPost.titleLabel?.font = .boldSystemFont(ofSize: 24)
        buttonPost.setTitle("Send", for: .normal)
        buttonPost.translatesAutoresizingMaskIntoConstraints = false
        buttonPostView.addSubview(buttonPost)
        
        buttonPost.setTitleColor(.white, for: .normal)
        buttonPost.backgroundColor = .systemTeal
        buttonPost.layer.cornerRadius = 5
        buttonPost.layer.masksToBounds = true
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            tableViewMessages.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableViewMessages.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewMessages.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewMessages.bottomAnchor.constraint(equalTo: buttonPostView.topAnchor, constant: -16),

            buttonPostView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            buttonPostView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            buttonPostView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            buttonPostView.topAnchor.constraint(equalTo: textViewNote.topAnchor, constant: -8),
            
            textViewNote.heightAnchor.constraint(equalToConstant: 65),
            textViewNote.bottomAnchor.constraint(equalTo: buttonPost.topAnchor, constant: -8),
            textViewNote.leadingAnchor.constraint(equalTo: buttonPostView.leadingAnchor, constant:
            8),
            textViewNote.trailingAnchor.constraint(equalTo: buttonPostView.trailingAnchor,
            constant: -8),
            
            buttonPost.bottomAnchor.constraint(equalTo: buttonPostView.bottomAnchor, constant: -8),
            buttonPost.leadingAnchor.constraint(equalTo: buttonPostView.leadingAnchor, constant: 128),
            buttonPost.trailingAnchor.constraint(equalTo: buttonPostView.trailingAnchor, constant: -128),
        ])
    }
}
