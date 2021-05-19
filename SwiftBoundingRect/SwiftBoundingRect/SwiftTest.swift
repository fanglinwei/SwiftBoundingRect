//
//  SwiftTest.swift
//  SwiftBoundingRect
//
//  Created by 方林威 on 2020/8/1.
//  Copyright © 2020 方林威. All rights reserved.
//

import UIKit

extension String {
    
    static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = ["您","好","中","国","w","i","d","t","h",",","。","a","b","c","\n", "1","5","2","j","A","J","0","🆚","👃"," "]
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }
}

func SwiftTestLabel() {
    print("玩命测试Label中....")
    
    let simpleTextUITimer = PerformanceTimer("简单文本计算UILabel")
    let simpleTextNOUITimer = PerformanceTimer("简单文本计算非UILabel")
    
    let attributedTextUITimer = PerformanceTimer("富文本计算UILabel")
    let attributedTextNOUITimer = PerformanceTimer("富文本计算非UILabel")
    
    for _ in 0 ..< 5000  {
        let text = String.random(ofLength: Int.random(in: 1 ... 100))
        let fitSize =  CGSize(width: .random(in: 0 ... 1000),
                              height: .random(in: 0 ... 1000))
        do {
            let label = UILabel.random(of: text)
            
            let sz1  = simpleTextUITimer { label.sizeThatFits(fitSize) }
            
            let sz2 = simpleTextNOUITimer {
                UILabel.boundingRect(
                    text,
                    size: fitSize,
                    attributes:
                    .font(label.font),
                    .numberOfLines(label.numberOfLines),
                    .lineBreakMode(label.lineBreakMode),
                    .textAlignment(label.textAlignment),
                    .minimumScaleFactor(label.minimumScaleFactor),
                    .shadowOffset(.zero)
                )
            }
            
            assert(sz1 == sz2, "简单文本计算出大小不一致")
        }
        
        //测试富文本
        let attributedText = NSMutableAttributedString(string: text)
        let range1 = NSRange(location: 0, length:  Int.random(in: 0 ... attributedText.length))
        let style1 = NSMutableParagraphStyle.random
        let font1: UIFont = .random
        
        let range2 = NSRange(location: range1.length, length: attributedText.length - range1.length)
        let style2 = NSMutableParagraphStyle.random
        let font2: UIFont = .random
        
        attributedText.addAttribute(.paragraphStyle, value: style1, range: range1)
        attributedText.addAttribute(.font, value: font1, range: range1)
        attributedText.addAttribute(.paragraphStyle, value: style2, range: range2)
        attributedText.addAttribute(.font, value: font2, range: range2)
        
        do {
            let label = UILabel.random(of: text)
            label.attributedText = attributedText
            
            let sz1 = attributedTextUITimer { label.sizeThatFits(fitSize) }
            let sz2 = attributedTextNOUITimer {
                UILabel.boundingRect(
                    attributedText,
                    size: fitSize,
                    attributes:
                    .font(label.font),
                    .numberOfLines(label.numberOfLines),
                    .lineBreakMode(label.lineBreakMode),
                    .textAlignment(label.textAlignment),
                    .minimumScaleFactor(label.minimumScaleFactor),
                    .shadowOffset(.zero)
                )
            }
            assert(sz1 == sz2, "富文本计算出大小不一致")
        }
    }
    
    print(simpleTextUITimer)
    print(simpleTextNOUITimer)
    print(attributedTextUITimer)
    print(attributedTextNOUITimer)
}

func SwiftTestTextView() {
    print("玩命测试TextView中....")
    let simpleTextUITimer = PerformanceTimer("简单文本计算UITextView")
    let simpleTextNOUITimer = PerformanceTimer("简单文本计算非UITextView")
    
    let attributedTextUITimer = PerformanceTimer("富文本计算UITextView")
    let attributedTextNOUITimer = PerformanceTimer("富文本计算非UITextView")
    /// 5000次测试计算
    for _ in 0 ..< 5000  {
        let text = String.random(ofLength: Int.random(in: 1 ... 100))
        let fitSize =  CGSize(width: .random(in: 0 ... 1000),
                              height: .random(in: 0 ... 1000))
        do {
            let label = UILabel.random(of: text)
            
            let sz1  = simpleTextUITimer { label.sizeThatFits(fitSize) }
            
            let sz2 = simpleTextNOUITimer {
                UILabel.boundingRect(
                    text,
                    size: fitSize,
                    attributes:
                    .font(label.font),
                    .numberOfLines(label.numberOfLines),
                    .lineBreakMode(label.lineBreakMode),
                    .textAlignment(label.textAlignment),
                    .minimumScaleFactor(label.minimumScaleFactor),
                    .shadowOffset(.zero)
                )
            }
            
            assert(sz1 == sz2, "简单文本计算出大小不一致")
        }
        
        //测试富文本
        let attributedText = NSMutableAttributedString(string: text)
        let range1 = NSRange(location: 0, length:  Int.random(in: 0 ... attributedText.length))
        let style1 = NSMutableParagraphStyle.random
        let font1: UIFont = .random
        
        let range2 = NSRange(location: range1.length, length: attributedText.length - range1.length)
        let style2 = NSMutableParagraphStyle.random
        let font2: UIFont = .random
        
        attributedText.addAttribute(.paragraphStyle, value: style1, range: range1)
        attributedText.addAttribute(.font, value: font1, range: range1)
        attributedText.addAttribute(.paragraphStyle, value: style2, range: range2)
        attributedText.addAttribute(.font, value: font2, range: range2)
        
        do {
            let label = UILabel.random(of: text)
            label.attributedText = attributedText
            
            let sz1 = attributedTextUITimer { label.sizeThatFits(fitSize) }
            
            let sz2 = attributedTextNOUITimer {
                UILabel.boundingRect(
                    attributedText,
                    size: fitSize,
                    attributes:
                    .font(label.font),
                    .numberOfLines(label.numberOfLines),
                    .lineBreakMode(label.lineBreakMode),
                    .textAlignment(label.textAlignment),
                    .minimumScaleFactor(label.minimumScaleFactor),
                    .shadowOffset(.zero)
                )
            }
            assert(sz1 == sz2, "富文本计算出大小不一致: sz1: \(sz1), sz2: \(sz2)")
        }
    }
    
    print(simpleTextUITimer)
    print(simpleTextNOUITimer)
    print(attributedTextUITimer)
    print(attributedTextNOUITimer)
}
