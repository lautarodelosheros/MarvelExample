//
//  KeychainManager.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 07/10/2022.
//

import Foundation

class KeychainManager {
    
    @discardableResult
    static func save(key: Key, string: String) -> OSStatus {
        let data = Data(string.utf8)
        return save(key: key, data: data)
    }
    
    static func getString(key: Key) -> String? {
        guard let data = getData(key: key) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    @discardableResult
    static func save(key: Key, data: Data) -> OSStatus {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecValueData: data
        ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    static func getData(key: Key) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    static func remove(key: Key) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
    }
    
    enum Key: String {
        
        case token = "token"
    }
}
