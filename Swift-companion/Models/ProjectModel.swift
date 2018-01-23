//
//  ProjectModel.swift
//  Swift-companion
//
//  Created by Quentin de Quelen on 23/01/2018.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import ObjectMapper

class ProjectModel: Mappable {
    var id:             Int?
    var occurrence:     Int = 0
    var finalMark:      Int = 0
    var status:         String?
    var validated:      Bool?
    var projectName:    String?
    var projectSlug:    String?
    var cursusId:       Int = 1


    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id          <- map["id"]
        occurrence  <- map["occurrence"]
        finalMark   <- map["final_mark"]
        status      <- map["status"]
        validated   <- map["validated?"]
        projectName <- map["project.name"]
        projectSlug <- map["project.slug"]
        cursusId    <- map["cursus_ids.0"]
    }
}
