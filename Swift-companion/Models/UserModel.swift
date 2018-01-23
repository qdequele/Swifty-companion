//
//  UserModel.swift
//  Swift-companion
//
//  Created by Quentin de Quelen on 23/01/2018.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import ObjectMapper

class UserModel: Mappable {
    var id:             Int?
    var email:          String?
    var login:          String?
    var firstName:      String?
    var lastName:       String?
    var phone:          String?
    var displayName:    String?
    var imageUrl:       String?
    var staff:          Bool = false
    var correctionPoint:Int = 0
    var poolMonth:      String?
    var poolYear:       String?
    var location:       String?
    var campus:         String?
    var title:          String?
    var wallet:         Int = 0
    var cursusUsers:    [CursusModel]?
    var projectsUsers:  [ProjectModel]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id              <- map["id"]
        email           <- map["email"]
        login           <- map["login"]
        firstName       <- map["first_name"]
        lastName        <- map["last_name"]
        phone           <- map["phone"]
        displayName     <- map["displayname"]
        imageUrl        <- map["image_url"]
        staff           <- map["staff?"]
        correctionPoint <- map["correction_point"]
        poolMonth       <- map["pool_month"]
        poolYear        <- map["pool_year"]
        location        <- map["location"]
        campus          <- map["campus.0.name"]
        title           <- map["titles.0.name"]
        wallet          <- map["wallet"]
        cursusUsers     <- map["cursus_users"]
        projectsUsers   <- map["projects_users"]
    }
}

