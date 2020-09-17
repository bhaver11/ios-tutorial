//
//  Item.swift
//  Todoey
//
//  Created by Synerg IITBombay on 02/07/20.
//  Copyright © 2020 Synerg IITBombay. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title:String = ""
    @objc dynamic var done:Bool = false
    @objc dynamic var created:Date?
    @objc dynamic var color:String = ""
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
