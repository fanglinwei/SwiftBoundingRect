//
//  Random.swift
//  SwiftBoundingRect
//
//  Created by 方林威 on 2020/8/1.
//  Copyright © 2020 方林威. All rights reserved.
//

import UIKit

extension UILabel {
    
    static func random(of text: String? = nil) -> UILabel {
        let label = UILabel()
        text.map { label.text = $0 }
        label.numberOfLines = .random(in: 0 ... 100)
        label.textAlignment = .random
        label.lineBreakMode = .random
        label.font = .random
        return label
    }
}

extension UITextView {
    
    static func random(of text: String? = nil) -> UITextView {
        let textView = UITextView()
        text.map { textView.text = $0 }
        textView.font = .random
        textView.textAlignment = .random
        textView.textContainer.lineBreakMode = .random
        textView.textContainer.maximumNumberOfLines = .random(in: 0 ... 100)
        textView.textContainer.lineFragmentPadding = .random(in: 0 ... 100)
//        textView.textContainerInset
        return textView
    }
}

extension NSTextAlignment {
    
    static var random: NSTextAlignment {
        NSTextAlignment(rawValue: Int.random(in: 0 ... 4))!
    }
}

extension NSLineBreakMode {
    
    static var random: NSLineBreakMode {
        NSLineBreakMode(rawValue: Int.random(in: 0 ... 5))!
    }
}

extension UIFont {
    
    static var random: UIFont {
        .systemFont(ofSize: CGFloat.random(in: 5.0 ... 35.0))
    }
}

extension NSMutableParagraphStyle {
    
    static var random: NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = .random(in: 0 ... 20)
        style.firstLineHeadIndent = .random(in: 0 ... 10)
        style.paragraphSpacing = .random(in: 0 ... 30)
        style.headIndent = .random(in: 0 ... 10)
        style.tailIndent = .random(in: 0 ... 10)
        return style
    }
}
