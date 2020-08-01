//
//  BoundingRect+UITextView.swift
//  SwiftBoundingRect
//
//  Created by 方林威 on 2020/8/1.
//  Copyright © 2020 方林威. All rights reserved.
//

import UIKit

extension UITextView {
    
    enum Attribute: Hashable {
        case font(UIFont)
        case textAlignment(NSTextAlignment)
        case textContainerInset(UIEdgeInsets)
        /// NSTextContainer
        case lineBreakMode(NSLineBreakMode)
        case lineFragmentPadding(CGFloat)
        case maximumNumberOfLines(Int)
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .font:                        hasher.combine("font")
            case .textAlignment:               hasher.combine("textAlignment")
            case .textContainerInset:          hasher.combine("textContainerInset")
            case .lineBreakMode:               hasher.combine("lineBreakMode")
            case .lineFragmentPadding:         hasher.combine("lineFragmentPadding")
            case .maximumNumberOfLines:        hasher.combine("maximumNumberOfLines")
            }
        }
        
        struct Context {
            var font: UIFont = .systemFont(ofSize: 14)
            var textAlignment: NSTextAlignment = .left
            var textContainerInset: UIEdgeInsets = .init(top: 8.0, left: 0, bottom: 8.0, right: 0)
            
            var lineBreakMode: NSLineBreakMode = .byTruncatingTail
            var lineFragmentPadding: CGFloat = 5.0
            var maximumNumberOfLines: Int = 0
        }
    }
}

private extension Array where Element == UITextView.Attribute {
    
    func context() -> UITextView.Attribute.Context {
        return Set(self).reduce(into: UITextView.Attribute.Context()) {
            switch $1 {
            case let .font(value):                  return $0.font = value
            case let .textAlignment(value):         return $0.textAlignment = value
            case let .textContainerInset(value):    return $0.textContainerInset = value
            case let .lineBreakMode(value):         return $0.lineBreakMode = value
            case let .lineFragmentPadding(value):   return $0.lineFragmentPadding = value
            case let .maximumNumberOfLines(value):  return $0.maximumNumberOfLines = value
            }
        }
    }
}

extension UITextView {
    
    static func boundingRect(_ string: String, size: CGSize, attributes: Attribute...) -> CGSize {
        guard !string.isEmpty else { return .zero }
        let context = attributes.context()
        let attributedString = NSAttributedString(
            string,
            context.font,
            context.lineBreakMode,
            context.textAlignment
        )
        return boundingRect(with: attributedString, size: size, context: context)
    }
    
    static func boundingRect(_ attributedString: NSAttributedString, size: CGSize, attributes: Attribute...) -> CGSize {
        guard !attributedString.string.isEmpty else { return .zero }
        var context = attributes.context()
        // 对于属性字符串总是加上默认的字体和段落信息。
        let text = NSMutableAttributedString(
            attributedString.string,
            context.font,
            context.lineBreakMode,
            context.textAlignment
        )
        
        attributedString.enumerateAttributes(in: NSRange(location: 0, length: attributedString.length), options: .init(rawValue: 0)) { (attrs, range, _) in
            text.addAttributes(attrs, range: range)
        }

        //这里再次取段落信息，因为有可能属性字符串中就已经包含了段落信息。
        if #available(iOS 11.0, *) {
            if let _style = text.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle {
                context.lineBreakMode = _style.lineBreakMode
            }
        }
        return boundingRect(with: attributedString, size: size, context: attributes.context())
    }
}

extension UITextView {

    fileprivate static func boundingRect(with attributedString: NSAttributedString, size: CGSize, context: Attribute.Context) -> CGSize {
        
        //调整fitsSize的值, 这里的宽度调整为只要宽度小于等于0或者显示一行都不限制宽度，而高度则总是改为不限制高度。
        var fitsSize = CGSize(width: size.width, height: .greatestFiniteMagnitude)
        if fitsSize.width <= 0 || context.maximumNumberOfLines == 1 {
            fitsSize.width = .greatestFiniteMagnitude
        }
        
        let textContainer = NSTextContainer(size: fitsSize)
        textContainer.lineBreakMode = context.lineBreakMode
        textContainer.lineFragmentPadding = context.lineFragmentPadding
        textContainer.maximumNumberOfLines = context.maximumNumberOfLines
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        let textStorage = NSTextStorage(attributedString: attributedString)
        textStorage.addLayoutManager(layoutManager)
        // 确保布局
        layoutManager.ensureLayout(for: textContainer)
        //计算属性字符串的bounds值。
        var rect = layoutManager.usedRect(for: textContainer)
        rect.size.width += (context.textContainerInset.left + context.textContainerInset.right)
        rect.size.height += (context.textContainerInset.top + context.textContainerInset.bottom)
        
        //取fitsSize和rect中的最小宽度值。
        rect.size.width =  min(fitsSize.width, rect.size.width)
        
        //转化为可以有效显示的逻辑点, 这里将原始逻辑点乘以缩放比例得到物理像素点，然后再取整，然后再除以缩放比例得到可以有效显示的逻辑点。
        let scale = UIScreen.main.scale
        rect.size.width = (rect.size.width * scale).rounded(.up) / scale
        rect.size.height = (rect.size.height * scale).rounded(.up) / scale
        return rect.size
    }
}

extension NSAttributedString {
    
    fileprivate convenience init(_ string: String, _ font: UIFont, _ lineBreakMode: NSLineBreakMode, _ textAlignment: NSTextAlignment) {
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        style.lineBreakMode = lineBreakMode
        
        //对于属性字符串总是加上默认的字体和段落信息。
        self.init(string: string, attributes: [.font: font, .paragraphStyle: style])
    }
}
