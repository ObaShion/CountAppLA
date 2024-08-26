//
//  DBCore.swift
//  CountAppLA
//
//  Created by 大場史温 on 2024/08/26.
//

import Foundation

class DBCore {
    
    let db = UserDefaults.standard
    
    func saveMembers(_ members: [Member]) {
           let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(members) {
               db.set(encoded, forKey: "members")
           }
       }
    
    func loadMembers() -> [Member]? {
            if let savedMembers = db.object(forKey: "members") as? Data {
                let decoder = JSONDecoder()
                if let loadedMembers = try? decoder.decode([Member].self, from: savedMembers) {
                    return loadedMembers
                }
            }
            return nil
        }
}
