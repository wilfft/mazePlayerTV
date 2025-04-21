//
//  Date+Extensions.swift.swift
//  VideoTest2
//
//  Created by William Moraes on 17/04/25.
//

// MARK: - Date Extensions
import Foundation

extension Date {
    func formatted(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
