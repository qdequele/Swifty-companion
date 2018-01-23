//
//  UserIdentifier.swift
//  Swift-companion
//
//  Created by Quentin DEQUELEN on 1/22/18.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import UIKit
import ObjectMapper

class UserIdentifier: Mappable {
    var id:     Int?
    var login:  String?
    var url:    String?

    required init?(map: Map) {

	}

	func mapping(map: Map) {
		id <- map["id"]
        login <- map["login"]
        url <- map["url"]
	}
}
