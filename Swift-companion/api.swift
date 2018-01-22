//
//  42API.swift
//  Swift-companion
//
//  Created by Quentin DEQUELEN on 1/22/18.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import Foundation
import Alamofire

class api {

    let url = "https://api.intra.42.fr"
    let UID : String = "5b05d7602ba4987bb7f0eb248ee8ce6351fef7a6d49adb68e780956f14f104b8"
    let secret : String = "e1d6c338212d4985ba104e1f3e3847c21bc5d1cca1698ae3abcf7e9ad0a78597"

    func getUserToken() {
        let fullUrl = NSURL(string: url + "/oauth/token")
        let request = NSMutableURLRequest(url: fullUrl! as URL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials&client_id=\(UID)&client_secret=\(secret)".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print (err)
            } else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let t = dic["access_token"] as? String {
                            let defaults:UserDefaults = UserDefaults.standard
                            defaults.set(t, forKey: "token_value")
                            print(t)
                            DispatchQueue.main.async {
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                        }
                    }
                } catch (let err) {
                    print (err)
                }
            }
        }
        task.resume()
    }

    func getUser(withLogin login: String?) -> [UserIdentifier] {

    }

    func getUsersRange(startWith login: String = " ") -> [UserIdentifier] {
        let parameters: Parameters = ["range[login]": "\(login),\(login + "z")"]

        let fullUrl = url + "/v2/users"

        let defaults:UserDefaults = UserDefaults.standard

        let token = defaults.object(forKey: "token_value") as? String ?? " "

        let headers: HTTPHeaders = [
            "Authorization": "Basic \(token)",
            "Accept": "application/json"
        ]

        Alamofire.request(fullUrl, headers: headers, parameters: parameters)
            .responseArray { (response: DataResponse<[UserIdentifier]>) in

                let forecastArray = response.result.value

                if let forecastArray = forecastArray {
                    for forecast in forecastArray {
                        print(forecast.id)
                        print(forecast.login)
                    }
                }
            }
    }
}
