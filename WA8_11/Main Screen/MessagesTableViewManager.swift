//
//  MessagesTableViewManager.swift
//  WA8_11
//
//  Created by Yu Zou on 11/13/23.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewMessagesID, for: indexPath) as! MassagesTableViewCell
        cell.labelName.text = messagesList[indexPath.row].name
        cell.labelTextMessages.text = messagesList[indexPath.row].textMessages
        cell.labelDate.text = messagesList[indexPath.row].date
        cell.labelTime.text = messagesList[indexPath.row].time
        
        return cell
    }
}
