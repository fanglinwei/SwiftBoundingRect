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
        let text = "文本Swift😊 文本313123234125432564ylv3-o6iuby-60mu5m36nu6v2590mc402u51c-0nv`5c12fqm09c-4u4-m0cm-043uc0p4um-0cu v-mc0vt-omi4-vmc-2cu30=9`i=-!@#!@#!@#$%@$#^%&$*%(&^)*&_(*&*^&%^$%#$#@!$%@^#&$*%^$%$#@!Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 文本Swift😊 "
        
        let attributedString = NSAttributedString(string: text)
        view.layoutIfNeeded()
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        textView.textContainer.lineBreakMode = .byCharWrapping
        textView.attributedText = attributedString
        textView.font = .systemFont(ofSize: 17)
        textView.textAlignment = .right
        view.layoutIfNeeded()
        let fitsSize = CGSize(width: 375, height: 200.0)
        print(textView.bounds.size)
        print("sizeThatFits: \(textView.sizeThatFits(fitsSize))")
        let size = UITextView.boundingRect(
            textView.attributedText!,
            size: fitsSize,
            attributes:
            .font(.systemFont(ofSize: 17)),
            .textContainerInset(textView.textContainerInset),
            .lineFragmentPadding(textView.textContainer.lineFragmentPadding),
            .maximumNumberOfLines(textView.textContainer.maximumNumberOfLines),
            .lineBreakMode(textView.textContainer.lineBreakMode)
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

