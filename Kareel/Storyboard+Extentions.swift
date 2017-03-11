//
//  Storyboard+Extentions.swift
//  Kareel
//
//  Created by Hironori Inagaki on 2017/03/11.
//  Copyright © 2017年 Hironori Inagaki. All rights reserved.
//

import UIKit

protocol StoryboardInitializable {}

extension StoryboardInitializable where Self: UIViewController {
  
  static func instantiateStoryboard() -> Self {
    let type = Mirror(reflecting: self).subjectType
    let name = String(describing: type).components(separatedBy: ".").first
    let storyboard = UIStoryboard(name: name!, bundle: nil)
    let viewController = storyboard.instantiateInitialViewController() as! Self
    return viewController
  }
}
