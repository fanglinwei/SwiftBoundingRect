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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // label 测试
//        labelTest()
        // 大量测试
        SwiftTestRun()
    }
    
    func labelTest() {
         let text = "全薇😊swift 中午 LEE 全薇😊swift 中午 LEE 全薇😊swift 中午 LEE 全薇😊swift 中午 LEE 全薇😊swift 中午 LEE 全薇😊swift 中午 LEE 全薇😊swift 中午 LEE 全薇😊swift 中午 LEE 全薇😊swift 中午 LEE 全薇😊swift 中午 LEE"
        
         let shadow = NSShadow()
         shadow.shadowOffset = CGSize(width: 0, height: 15)
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
                                 .applying(attributes: [.shadow: shadow1], toRangesMatching: "薇")
                                 .applying(attributes: [.shadow: shadow2], toRangesMatching: "swift")
                                 .applying(attributes: [.shadow: shadow3], toRangesMatching: "中午")
         
         label.numberOfLines = 0
         view.layoutIfNeeded()

         print(label.bounds.size)
         print(label.sizeThatFits(CGSize(width: 375, height: 100)))

        let size1 = label.attributedText!.boundingRect(with: CGSize(width: 375, height: 100), numberOfLines: label.numberOfLines, font: label.font, lineBreakMode: label.lineBreakMode, textAlignment: label.textAlignment, minimumScaleFactor: label.minimumScaleFactor)

         print(size1)
    }
}

