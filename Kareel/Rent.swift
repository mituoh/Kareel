//
//  Book.swift
//  Kareel
//
//  Created by Hironori Inagaki on 2017/03/11.
//  Copyright © 2017年 Hironori Inagaki. All rights reserved.
//

import Foundation

final class Rent {
  static let shared = Rent()
  
  var isbn: String = ""
  
  func clear() {
    self.isbn = ""
  }
  
  func amazonURL() -> URL {
    return URL(string: String(format: "https://amazon.co.jp/dp/%@", isbn))!
  }
}
