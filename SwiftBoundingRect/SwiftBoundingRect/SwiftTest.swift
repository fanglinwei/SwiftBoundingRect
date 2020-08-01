//
//  SwiftTest.swift
//  CalcTextDemo
//
//  Created by 方林威 on 2020/8/1.
//  Copyright © 2020 方林威. All rights reserved.
//

import UIKit

func SwiftTestRun() {
    print("玩命计算中....")
    let simpleTextUITimer = PerformanceTimer()
    let simpleTextNOUITimer = PerformanceTimer()
    let simpleTextRectTimer = PerformanceTimer()
    
    let attributedTextUITimer = PerformanceTimer()
    let attributedTextNOUITimer = PerformanceTimer()
    let attributedTextRectTimer = PerformanceTimer()
    
    for _ in 0 ..< 5000  {
        let text = String.random(ofLength: Int.random(in: 1 ... 100))
        let fitSize =  CGSize(width: .random(in: 0 ... 1000),
                              height: .random(in: 0 ... 1000))
        do {
            let label = UILabel.random(of: text)
            
            let sz1  = simpleTextUITimer { label.sizeThatFits(fitSize) }

            let sz2 = simpleTextNOUITimer { label.text!.boundingRect(
                with: fitSize,
                numberOfLines: label.numberOfLines,
                font: label.font,
                lineBreakMode: label.lineBreakMode,
                textAlignment: label.textAlignment,
                minimumScaleFactor: label.minimumScaleFactor,
                shadowOffset: .zero
                )
            }
            
            let sz3 = simpleTextRectTimer {
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
            assert(sz1 == sz3, "简单文本计算出大小不一致")
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
                attributedText.boundingRect(
                    with: fitSize,
                    numberOfLines: label.numberOfLines,
                    font: label.font,
                    lineBreakMode: label.lineBreakMode,
                    textAlignment: label.textAlignment,
                    minimumScaleFactor: label.minimumScaleFactor,
                    shadowOffset: .zero
                )
            }
            
            let sz3 = attributedTextRectTimer {
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
            assert(sz1 == sz3, "富文本计算出大小不一致")
        }
    }
    
    print(String(format: "简单文本计算UILabel总耗时(毫秒):%.3f, 平均耗时:%.3f", simpleTextUITimer.total, simpleTextUITimer.average))
    print(String(format: "简单文本计算非UILabel总耗时(毫秒):%.3f, 平均耗时:%.3f", simpleTextNOUITimer.total, simpleTextNOUITimer.average))
    print(String(format: "简单文本计算非UILabel TextRect总耗时(毫秒):%.3f, 平均耗时:%.3f", simpleTextRectTimer.total, simpleTextRectTimer.average))
    
    print(String(format: "富文本计算UILabel总耗时(毫秒):%.3f, 平均耗时:%.3f", attributedTextUITimer.total, attributedTextUITimer.average))
    print(String(format: "富文本计算非UILabel总耗时(毫秒):%.3f, 平均耗时:%.3f", attributedTextNOUITimer.total, attributedTextNOUITimer.average))
    print(String(format: "富文本计算非UILabel TextRect总耗时(毫秒):%.3f, 平均耗时:%.3f", attributedTextRectTimer.total, attributedTextRectTimer.average))
}

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
