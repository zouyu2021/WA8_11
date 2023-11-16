//
//  Messages.swift
//  WA8_11
//
//  Created by Yu Zou on 11/13/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable{
    @DocumentID var id: String?
    var senderName: String
    var textMessages: String
    var momentInTime: Date
    
    init(senderName: String, textMessages: String, momentInTime: Date) {
        self.senderName   = senderName
        self.textMessages = textMessages
        self.momentInTime = momentInTime
    }
}
