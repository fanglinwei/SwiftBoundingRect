//
//  NSAttributedStringExtension.swift
//  CalcTextDemo
//
//  Created by 方林威 on 2020/8/1.
//  Copyright © 2020 方林威. All rights reserved.
//

import Foundation

extension NSAttributedString {
    
    /// SwifterSwift: Apply attributes to occurrences of a given string
    ///
    /// - Parameters:
    ///   - attributes: Dictionary of attributes
    ///   - target: a subsequence string for the attributes to be applied to
    /// - Returns: An NSAttributedString with attributes applied on the target string
    func applying<T: StringProtocol>(attributes: [NSAttributedString.Key: Any], toOccurrencesOf target: T) -> NSAttributedString {
        let pattern = "\\Q\(target)\\E"

        return applying(attributes: attributes, toRangesMatching: pattern)
    }
    
    func applying(attributes: [NSAttributedString.Key: Any],
                  toRangesMatching pattern: String,
                  options: NSRegularExpression.Options = []) -> NSAttributedString {
        guard let pattern = try? NSRegularExpression(pattern: pattern, options: options) else { return self }

        let matches = pattern.matches(in: string, options: [], range: NSRange(0..<length))
        let result = NSMutableAttributedString(attributedString: self)

        for match in matches {
            result.addAttributes(attributes, range: match.range)
        }
        return result
    }
}


