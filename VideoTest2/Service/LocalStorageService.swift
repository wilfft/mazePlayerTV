//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

// MARK: - Local Storage Service
import Foundation

class LocalStorageService {
    private let userDefaults = UserDefaults.standard
    
    func setValue(_ value: Any, forKey key: String) -> Bool {
        userDefaults.set(value, forKey: key)
        return userDefaults.synchronize()
    }
    
    func getValue(forKey key: String) -> Any? {
        return userDefaults.object(forKey: key)
    }
    
    func setData(_ data: Data, forKey key: String) -> Bool {
        userDefaults.set(data, forKey: key)
        return userDefaults.synchronize()
    }
    
    func getData(forKey key: String) -> Data? {
        return userDefaults.data(forKey: key)
    }
    
    func setBool(_ value: Bool, forKey key: String) -> Bool {
        userDefaults.set(value, forKey: key)
        return userDefaults.synchronize()
    }
    
    func getBool(forKey key: String) -> Bool? {
        if userDefaults.object(forKey: key) != nil {
            return userDefaults.bool(forKey: key)
        }
        return nil
    }
    
    func removeValue(forKey key: String) -> Bool {
        userDefaults.removeObject(forKey: key)
        return userDefaults.synchronize()
    }
}
