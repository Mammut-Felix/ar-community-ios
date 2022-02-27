//
//  KeyValueStore.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 03.02.22.
//

import Foundation
import ParseSwift

struct KeyValueStore: ParseKeyValueStore {
    var userDefaults = UserDefaults(suiteName: "parse")!

    mutating func delete(valueFor key: String) throws {
        userDefaults.removeObject(forKey: key)
    }

    mutating func deleteAll() throws {
        let dictionary = userDefaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
    }

    mutating func get<T>(valueFor key: String) throws -> T? where T: Decodable {
        if let data = userDefaults.object(forKey: key) as? Data {
            return try JSONDecoder().decode(T.self, from: data)
        } else {
            return nil
        }
    }

    mutating func set<T>(_ object: T, for key: String) throws where T: Encodable {
        let data = try JSONEncoder().encode(object)
        userDefaults.set(data, forKey: key)
    }
}
