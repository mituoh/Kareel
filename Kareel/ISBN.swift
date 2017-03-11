//
//  ISBN.swift
//  Kareel
//
//  Created by Hironori Inagaki on 2017/03/11.
//  Copyright © 2017年 Hironori Inagaki. All rights reserved.
//

import Foundation

final class ISBN {
  
  // 1行目のJANコード用
  func convart(value: String) -> String? {
    let v = NSString(string: value).longLongValue
    let prefix: Int64 = Int64(v / 10000000000)
    guard prefix == 978 || prefix == 979 else { return nil } // ISBNかチェック
    let isbn9: Int64 = (v % 10000000000) / 10
    var sum: Int64 = 0
    var tmpISBN = isbn9
    
    var i = 10
    while i > 0 && tmpISBN > 0 {
      let divisor: Int64 = Int64(pow(10, Double(i - 2)))
      sum += (tmpISBN / divisor) * Int64(i)
      tmpISBN %= divisor
      i -= 1
    }
    
    let checkdigit = 11 - (sum % 11)
    return String(format: "%lld%@", isbn9, (checkdigit == 10) ? "X" : String(format: "%lld", checkdigit % 11))
  }
}
