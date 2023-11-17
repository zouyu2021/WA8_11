//
//  User.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import Foundation
import FirebaseFirestoreSwift

// adopt the Codable protocol to enable encoding and decoding.
struct Contact: Codable{
    @DocumentID var id: String?
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name  = name
        self.email = email
    }
}
