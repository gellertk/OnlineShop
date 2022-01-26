//
//  ArrayExtension.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 26.01.2022.
//

import Foundation

extension Array where Element == String {
    
    func convertToDictionary(keys: [String]) -> [String: String] {
        guard keys.count == self.count else {
            return [:]
        }
        var result: [String: String] = [:]
        for index in keys.indices {
            result[keys[index]] = self[index]
        }
        return result
    }
    
}
