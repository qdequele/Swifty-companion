//
//  LocalStore.swift
//  Swift-companion
//
//  Created by Quentin de Quelen on 23/01/2018.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import Foundation

struct LocalStoreString {
    private var key: String = ""
    init(key: String) {
        self.key = key
    }

    func set(_ record: String) {
        UserDefaults.standard.set(record, forKey: self.key)
        UserDefaults.standard.synchronize()
    }

    func get() -> String? {
        return UserDefaults.standard.value(forKey: self.key) as! String?
    }

    func delete() {
        UserDefaults.standard.removeObject(forKey: self.key)
        UserDefaults.standard.synchronize()
    }
}

struct LocalStoreBool {
    private var key: String = ""
    init(key: String) {
        self.key = key
    }

    func set(_ record: Bool) {
        UserDefaults.standard.set(record, forKey: self.key)
        UserDefaults.standard.synchronize()
    }

    func get() -> Bool {
        return UserDefaults.standard.value(forKey: self.key) as? Bool ?? false
    }

    func delete() {
        UserDefaults.standard.removeObject(forKey: self.key)
        UserDefaults.standard.synchronize()
    }
}

struct LocalStore {
    static var accessToken            = LocalStoreString(key: "access_token")

    static func flush() {
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
    }
}
