//
//  String+Extensions.swift
//  VideoTest2
//
//  Created by William Moraes on 17/04/25.
//

// MARK: - String Extensions
import Foundation

extension String {
    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    var htmlToString: String {
        guard let data = self.data(using: .utf8) else { return self }
        do {
            let attributedString = try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
            )
            return attributedString.string
        } catch {
            return self
        }
    }
}
