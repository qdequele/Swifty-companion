//
//  42API.swift
//  Swift-companion
//
//  Created by Quentin DEQUELEN on 1/22/18.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON


class api {

    let url = "https://api.intra.42.fr"
    let UID : String = "5b05d7602ba4987bb7f0eb248ee8ce6351fef7a6d49adb68e780956f14f104b8"
    let secret : String = "e1d6c338212d4985ba104e1f3e3847c21bc5d1cca1698ae3abcf7e9ad0a78597"

    func getUserToken() {

        let fullUrl = url + "/oauth/token"

        let parameters: Parameters = [
            "grant_type": "client_credentials",
            "client_id": UID,
            "client_secret": secret
        ]

        Alamofire.request(fullUrl, method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                LocalStore.accessToken.set(json["access_token"].stringValue)
            case .failure(let error):
                print(error)
            }
        }

    }

    func getUsersRange(startWith login: String = " ", _ callback: @escaping ([UserIdentifier])->()) {
        let parameters: Parameters = ["range[login]": "\(login),\(login + "z")"]
        let fullUrl = url + "/v2/users"
        guard let access_token = LocalStore.accessToken.get() else {return}
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(access_token)"
        ]

        Alamofire.request(fullUrl, parameters: parameters, headers: headers)
            .responseArray { (response: DataResponse<[UserIdentifier]>) in

                let responses = response.result.value
                print(response.error.debugDescription)
                if let responses = responses {
                    callback(responses)
                }
            }
    }

    func getUser(withId id: Int, _ callback: @escaping (UserModel)->()) {
        let fullUrl = url + "/v2/users/" + String(id)
        guard let access_token = LocalStore.accessToken.get() else {return}
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(access_token)"
        ]
        print(fullUrl)
        Alamofire.request(fullUrl, headers: headers)
            .responseObject { (response: DataResponse<UserModel>) in
                let response = response.result.value
                if let response = response {
                    callback(response)
                }
        }
    }
}
