//
//  PerformanceTimer.swift
//  SwiftBoundingRect
//
//  Created by 方林威 on 2020/8/1.
//  Copyright © 2020 方林威. All rights reserved.
//

import UIKit

/// 性能测试计时器工具
class PerformanceTimer {
    
    private(set) var records: [CFTimeInterval] = []
    
    private var start: CFTimeInterval = 0
    
    func reset() {
        records = []
    }
    
    /// 耗时时间
    var value: CFTimeInterval { records.reduce(0, +) }
}

extension PerformanceTimer {
    
    /// 闭包执行操作
    /// - Parameter work: 执行操作
    func execute(_ work: () -> Void) {
        let start = CACurrentMediaTime()
        work()
        records.append(CACurrentMediaTime() - start)
    }
    
    func execute<T>(_ work: () -> T) -> T {
        let start = CACurrentMediaTime()
        defer { records.append(CACurrentMediaTime() - start) }
        return work()
    }
    
    /// 快捷调用
    func callAsFunction(_ work: () -> Void) {
        execute(work)
    }
    
    func callAsFunction<T>(_ work: () -> T) -> T {
        return execute(work)
    }
}

extension PerformanceTimer {
    /*
     计时操作一次进入对应一次离开
     eg:
     let timer = PerformanceTimer()
     timer.enter()
     work()
     timer.leave()
     
     or:
     let timer = PerformanceTimer()
     timer.enter()
     DispatchQueue.main.async {
         work()
         timer.leave()
     }
     */
    /// 进入计时
    func enter() {
        start = CACurrentMediaTime()
    }
    
    /// 离开计时
    func leave() {
        records.append(CACurrentMediaTime() - start)
    }
}

extension PerformanceTimer {
    
    /// 总耗时(毫秒)
    var total: CFTimeInterval { value * 1000 }
    
    /// 执行次数
    var count: Int { records.count }
    
    /// 平均耗时
    var average: CFTimeInterval { total / Double(count) }
}
