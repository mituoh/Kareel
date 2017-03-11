//
//  DoneViewController.swift
//  Kareel
//
//  Created by Hironori Inagaki on 2017/03/11.
//  Copyright © 2017年 Hironori Inagaki. All rights reserved.
//

import UIKit

final class DoneViewController: UIViewController, StoryboardInitializable {
  @IBOutlet weak var returnDateLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    showReturnDate()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Private
  private func showReturnDate() {
    let formatter = DateFormatter()
    let jaLocale = Locale(identifier: "ja_JP")
    formatter.locale = jaLocale
    formatter.dateFormat = "返却期限  MM月dd日"
    
    let now = Date()
    // 3週間後の日付
    let returnDate = Date(timeInterval: 60*60*24*21, since: now)
    returnDateLabel.text = formatter.string(from: returnDate)
  }
  
  // MARK: - Action
  @IBAction func tapCloseButton(_ sender: Any) {
    self.navigationController?.dismiss(animated: true, completion: { 
      Rent.shared.clear()
    })
  }
}
