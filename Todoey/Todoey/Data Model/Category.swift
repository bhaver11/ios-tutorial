//
//  Category.swift
//  Todoey
//
//  Created by Synerg IITBombay on 02/07/20.
//  Copyright © 2020 Synerg IITBombay. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String = ""
    @objc dynamic var color:String = ""
    let items = List<Item>()
}
