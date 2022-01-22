//
//  ArrayExtension.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 22.01.2022.
//

import Foundation

extension String {
    
    func getPossibleMemoryCollection() -> [String] {
        let formattedString = self.replacingOccurrences(of: " ", with: "")
        var formattedArray = formattedString.components(separatedBy: ",")
        for index in formattedArray.indices {
            formattedArray[index] = getFormattedSize(size: formattedArray[index])
        }
        return formattedArray
    }
    
    func getPossibleColorCollection() -> [String] {
        let formattedString = self.replacingOccurrences(of: " ", with: "")
        let formattedArray = formattedString.components(separatedBy: ",")
        return formattedArray
    }
    
    func getFormattedSize(size: String) -> String {
        if let sizeInt = Int(size) {
            let byteCount = sizeInt * 1000000000
            var result = ByteCountFormatter().string(fromByteCount: Int64(byteCount))
            if let commaRange = result.range(of: ","), let spaceRange = result.range(of: " ") {
                result.removeSubrange(commaRange.lowerBound..<spaceRange.lowerBound)
            }
            return result
        }
        return size
    }
    
}
