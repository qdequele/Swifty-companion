//
//  CursusModel.swift
//  Swift-companion
//
//  Created by Quentin de Quelen on 23/01/2018.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import ObjectMapper

class CursusModel: Mappable {
    var id:             Int?
    var grade:          String?
    var level:          Float?
    var name:           String?
    var slug:           String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id          <- map["cursus_id"]
        grade       <- map["grade"]
        level       <- map["level"]
        name       <- map["cursus.name"]
        slug       <- map["cursus.slug"]
    }
}
