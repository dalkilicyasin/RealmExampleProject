//
//  ShoppingList.swift
//  RealmExampleProject
//
//  Created by yasin on 22.06.2024.
//

import Foundation
import RealmSwift

class ShoppingList: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var address: String
    @Persisted var imageData: Data
    @Persisted var anyStringData: String
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    
}
