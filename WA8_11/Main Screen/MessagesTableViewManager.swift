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
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewContactID, for: indexPath) as! ContactTableViewCell
        cell.labelName.text = contactList[indexPath.row].name
        return cell
    }
    
    // when the user click the row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if the user selects a row, we will call the getContactDetails(contact)
        getChatDetails(contact: self.contactList[indexPath.row])
    }
}
