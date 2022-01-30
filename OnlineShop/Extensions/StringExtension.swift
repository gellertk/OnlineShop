//
//  ArrayExtension.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 22.01.2022.
//

import Foundation

extension String {
    
    func toArray() -> [String] {
        guard self != "" else {
            return []
        }
        let formattedString = self.replacingOccurrences(of: " ", with: "")
        let formattedArray = formattedString.components(separatedBy: ",")
        return formattedArray
    }
    
    func getFormattedSize() -> String {
        if let sizeInt = Int(self) {
            let byteCount = sizeInt * 1000000000
            var result = ByteCountFormatter().string(fromByteCount: Int64(byteCount))
            if let commaRange = result.range(of: ","), let spaceRange = result.range(of: " ") {
                result.removeSubrange(commaRange.lowerBound..<spaceRange.lowerBound)
            }
            return result
        }
        return self
    }
    
}
