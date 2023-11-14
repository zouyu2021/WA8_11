//
//  Message.swift
//  WA8_11
//
//  Created by Yu Zou on 11/13/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Messages: Codable{
    @DocumentID var id: String?
    var name: String
    var textMessages: String
    var date: String
    var time: String
    
    init(name: String, textMessages: String, date: String, time: String) {
        self.name = name
        self.textMessages = textMessages
        self.date = date
        self.time = time
    }
}
