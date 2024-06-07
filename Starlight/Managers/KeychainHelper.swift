//
//  KeychainHelper.swift
//  Starlight
//
//  Created by Tanishk Sahni on 06/06/24.
//

import Security
import SwiftUI


class KeychainHelper {
    static let shared = KeychainHelper()

    func save(_ data: Data, forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("Successfully saved data to keychain for key: \(key)")
        } else {
            print("Failed to save data to keychain for key: \(key)")
        }
    }

    func read(forKey key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecSuccess {
            print("Successfully read data from keychain for key: \(key)")
        } else {
            print("Failed to read data from keychain for key: \(key)")
        }
        return item as? Data
    }

    func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            print("Successfully deleted data from keychain for key: \(key)")
        } else {
            print("Failed to delete data from keychain for key: \(key)")
        }
    }
}
