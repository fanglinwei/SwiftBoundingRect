//
//  SwiftBoundingRect.swift
//  SwiftBoundingRect
//
//  Created by 方林威 on 2020/7/22.
//  Copyright © 2020 方林威. All rights reserved.
//

import UIKit

extension String {
    
    func boundingRect(with size: CGSize,
                      numberOfLines: Int = 0,
                      font: UIFont = .systemFont(ofSize: 17),
                      lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                      textAlignment: NSTextAlignment = .left,
                      minimumScaleFactor: CGFloat = 0,
                      shadowOffset: CGSize = .zero
                      ) -> CGSize {
        guard !isEmpty else { return .zero }
        //对于属性字符串总是加上默认的字体和段落信息。
        let attributedString = NSMutableAttributedString(self, font, lineBreakMode, textAlignment)
        return attributedString._boundingRect(with: size,
                                              firstLineHeadIndent: 0,
                                              numberOfLines: numberOfLines,
                                              minimumScaleFactor: minimumScaleFactor,
                                              shadowOffset: shadowOffset
        )
    }
}

extension NSAttributedString {
    
    func boundingRect(with size: CGSize,
                      numberOfLines: Int = 0,
                      font: UIFont = .systemFont(ofSize: 17),
                      lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                      textAlignment: NSTextAlignment = .left,
                      minimumScaleFactor: CGFloat = 0,
                      shadowOffset: CGSize? = nil
                      ) -> CGSize {
        guard !string.isEmpty else { return .zero }
        //对于属性字符串总是加上默认的字体和段落信息。
        let attributedString = NSMutableAttributedString(string, font, lineBreakMode, textAlignment)
        enumerateAttributes(in: NSRange(location: 0, length: length), options: .init(rawValue: 0)) { (attrs, range, stop) in
            attributedString.addAttributes(attrs, range: range)
        }
        
        var firstLineHeadIndent: CGFloat = 0
        var shadowOffset = shadowOffset
        //这里再次取段落信息，因为有可能属性字符串中就已经包含了段落信息。
        if #available(iOS 11.0, *) {
            if let _style = attributedString.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle {
                firstLineHeadIndent = _style.firstLineHeadIndent
            }
            
            if shadowOffset == nil ,
                let shadow = attributedString.attribute(.shadow, at: 0, effectiveRange: nil) as? NSShadow {
                shadowOffset = shadow.shadowOffset
            }
        }
        
        return attributedString._boundingRect(with: size,
                                              firstLineHeadIndent: firstLineHeadIndent,
                                              numberOfLines: numberOfLines,
                                              minimumScaleFactor: minimumScaleFactor,
                                              shadowOffset: shadowOffset ?? .zero
        )
    }
    
    fileprivate func _boundingRect(with size: CGSize,
                                   firstLineHeadIndent: CGFloat,
                                   numberOfLines: Int,
                                   minimumScaleFactor: CGFloat,
                                   shadowOffset: CGSize) -> CGSize {
        //构造出一个NSStringDrawContext
        //因为下面几个属性都是未公开的属性，所以我们用KVC的方式来实现。
        let context = NSStringDrawingContext()
        context.minimumScaleFactor = minimumScaleFactor
        context.setValue(numberOfLines, forKey: "maximumNumberOfLines")
        context.setValue(true, forKey: "wantsNumberOfLineFragments")
        
        if numberOfLines != 1 { context.setValue(true, forKey: "wrapsForTruncationMode") }
        
        //调整fitsSize的值, 这里的宽度调整为只要宽度小于等于0或者显示一行都不限制宽度，而高度则总是改为不限制高度。
        var fitsSize = size
        fitsSize.height = .greatestFiniteMagnitude
        if fitsSize.width <= 0 || numberOfLines == 1 {
            fitsSize.width = .greatestFiniteMagnitude
        }
        //计算属性字符串的bounds值。
        var rect = boundingRect(with: fitsSize, options: .usesLineFragmentOrigin, context: context)
        
        //需要对段落的首行缩进进行特殊处理！
        //如果只有一行则直接添加首行缩进的值，否则进行特殊处理。。
        if #available(iOS 11.0, *),
            firstLineHeadIndent != 0.0,
            let numberOfDrawingLines = context.value(forKey: "numberOfLineFragments") as? Int {
            //得到绘制出来的行数
            switch numberOfDrawingLines {
            case 1:
                rect.size.width += firstLineHeadIndent
            default:
                //取内容的行数。
                let lines = string.components(separatedBy: .newlines)
                //有效的内容行数要减去最后一行为空行的情况。
                let numberOfContentLines = lines.count - (lines.last?.count == 0 ? 1 : 0)
                var _numberOfLines = numberOfLines == 0 ? .max : numberOfLines
                _numberOfLines = min(_numberOfLines, numberOfContentLines)
                //只有绘制的行数和指定的行数相等时才添加上首行缩进！这段代码根据反汇编来实现，但是不理解为什么相等才设置？
                if numberOfDrawingLines == _numberOfLines {
                    rect.size.width += firstLineHeadIndent
                }
            }
        }
        //加上阴影的偏移
        if shadowOffset != .zero {
            rect.size.width += abs(shadowOffset.width)
            rect.size.height += abs(shadowOffset.height)
        }
        //取fitsSize和rect中的最小宽度值。
        rect.size.width =  min(fitsSize.width, rect.size.width)
        
        //转化为可以有效显示的逻辑点, 这里将原始逻辑点乘以缩放比例得到物理像素点，然后再取整，然后再除以缩放比例得到可以有效显示的逻辑点。
        let scale = UIScreen.main.scale
        rect.size.width = (rect.size.width * scale).rounded(.up) / scale
        rect.size.height = (rect.size.height * scale).rounded(.up) / scale
        return rect.size
    }
    
    fileprivate convenience init(_ string: String, _ font: UIFont, _ lineBreakMode: NSLineBreakMode, _ textAlignment: NSTextAlignment) {
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        style.lineBreakMode = lineBreakMode
        
        //系统大于等于11才设置行断字策略。
        if #available(iOS 11.0, *) { style.setValue(1, forKey: "lineBreakStrategy") }
        
        //对于属性字符串总是加上默认的字体和段落信息。
        self.init(string: string, attributes: [.font: font, .paragraphStyle: style])
    }
}
