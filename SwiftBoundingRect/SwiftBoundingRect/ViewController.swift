//
//  ViewController.swift
//  SwiftBoundingRect
//
//  Created by 方林威 on 2020/8/1.
//  Copyright © 2020 方林威. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // label 测试
//        labelTest()
        // 大量测试UILabel
//        SwiftTestLabel()
        
        textViewTest()
        // 大量测试UITextView
//        SwiftTestLabel()
    }
    
    func textViewTest() {
        let text = "文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 "
        
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 20)
        shadow.shadowColor = UIColor.red
        
        let attributedString = NSAttributedString(string: text, attributes: [ .shadow: shadow])
        
        let shadow1 = NSShadow()
        shadow1.shadowOffset = CGSize(width: 0, height: 10)
        shadow1.shadowColor = UIColor.red
        
        let shadow2 = NSShadow()
        shadow2.shadowOffset = CGSize(width: 0, height: 10)
        shadow2.shadowColor = UIColor.blue
        
        let shadow3 = NSShadow()
        shadow3.shadowOffset = CGSize(width: 0, height: 5)
        shadow2.shadowColor = UIColor.yellow
        
        textView.attributedText = attributedString
                                .applying(attributes: [.font: UIFont.systemFont(ofSize: 20)], toOccurrencesOf: "Swift")
                                .applying(attributes: [.shadow: shadow1], toRangesMatching: "文字")
                                .applying(attributes: [.shadow: shadow2], toRangesMatching: "swift")
        
        textView.textAlignment = .right
        view.layoutIfNeeded()
        print(textView.bounds.size)
        print(textView.sizeThatFits(CGSize(width: 375, height: 200.0)))
        let size = UITextView.boundingRect(
            textView.attributedText!,
            size: CGSize(width: 375, height: 200),
            attributes: .font(.systemFont(ofSize: 17))
        )
        print(size)
    }
    
    func labelTest() {
         let text = "文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 文字Swift😊 "
        
         let shadow = NSShadow()
         shadow.shadowOffset = CGSize(width: 0, height: 5)
         shadow.shadowColor = UIColor.red
         
         let attributedString = NSAttributedString(string: text, attributes: [ .shadow: shadow])
         
         let shadow1 = NSShadow()
         shadow1.shadowOffset = CGSize(width: 0, height: 10)
         shadow1.shadowColor = UIColor.red
         
         let shadow2 = NSShadow()
         shadow2.shadowOffset = CGSize(width: 0, height: 10)
         shadow2.shadowColor = UIColor.blue
         
         let shadow3 = NSShadow()
         shadow3.shadowOffset = CGSize(width: 0, height: 5)
         shadow2.shadowColor = UIColor.yellow
         
         label.attributedText = attributedString
                                 .applying(attributes: [.shadow: shadow1], toRangesMatching: "文字")
                                 .applying(attributes: [.shadow: shadow2], toRangesMatching: "swift")
         
         label.numberOfLines = 0
         view.layoutIfNeeded()

         print(label.bounds.size)
         print(label.sizeThatFits(CGSize(width: 375, height: 100)))

        let size = UILabel.boundingRect(
            label.attributedText!,
            size: CGSize(width: 375, height: 100),
            attributes:
            .font(label.font),
            .lineBreakMode(label.lineBreakMode),
            .numberOfLines(label.numberOfLines),
            .textAlignment(label.textAlignment),
            .minimumScaleFactor(label.minimumScaleFactor),
            .shadowOffset(label.shadowOffset)
        )
         print(size)
    }
}

