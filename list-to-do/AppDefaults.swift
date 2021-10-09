//
//  AppDefaults.swift
//  list-to-do
//
//  Created by Igor Postoev on 29.09.2021.
//

struct AppDefaults {
    
    private struct Key {
        static let firstRunDate = "firstRunDate"
    }
    
    static var firstRunDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: Key.firstRunDate) as? Date
        }
        set (date) {
            return UserDefaults.standard.setValue(date, forKey: Key.firstRunDate)
        }
    }
    
    static var isFirstAppLaunch: Bool {
        if let _ = UserDefaults.standard.object(forKey: Key.firstRunDate) {
            return false
        }
        firstRunDate = Date()
        return true
    }
}
