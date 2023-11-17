//
//  MsgTableViewManager.swift
//  WA8_11
//
//  Created by 李凱鈞 on 11/16/23.
//

import Foundation
import UIKit


extension MessagesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell
        
        if messagesList[indexPath.row].senderName == currentUser?.displayName{
            cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewMessages, for: indexPath) as! SelfMessagesTableViewCell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewMessages, for: indexPath) as! FriendMessagesTableViewCell
        }
        
     //   cell.messageLabel.text = messagesList[indexPath.row].textMessages
        
//        if let messageCell = cell as? MessageTableViewCell {
//            messageCell.messageLabel.text = messagesList[indexPath.row].textMessages
//        }

        return cell
    }
}
