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

        let message = messagesList[indexPath.row]
        
        if message.senderName == currentUser?.displayName {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewSelfMessageID, for: indexPath) as? SelfMessagesTableViewCell {
                cell.labelSender.text = message.senderName
                
                // Convert Date to String using a DateFormatter
                let dateFormatter        = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy 'at' HH:mm"
                cell.labelDateTime.text  = dateFormatter.string(from: message.timestamp)
        
                cell.labelMessage.text = message.text
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewFriendMessageID, for: indexPath) as? FriendMessagesTableViewCell {
                cell.labelSender.text = message.senderName
                
                // Convert Date to String using a DateFormatter
                let dateFormatter        = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy 'at' HH:mm"
                cell.labelDateTime.text  = dateFormatter.string(from: message.timestamp)
        
                cell.labelMessage.text = message.text
                return cell
            }
        }

        // Return a default cell if none of the above conditions are met
        return UITableViewCell()
    }
}
