//
//  ConfirmViewController.swift
//  Kareel
//
//  Created by Hironori Inagaki on 2017/03/11.
//  Copyright © 2017年 Hironori Inagaki. All rights reserved.
//

import UIKit
import DigitsKit

final class ConfirmViewController: UIViewController, StoryboardInitializable {
  @IBOutlet weak var webView: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    openWebView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Private
  private func openWebView() {
    print(Rent.shared.amazonURL())
    let request = URLRequest(url: Rent.shared.amazonURL())
    webView.loadRequest(request)
  }
  
  private func segueForNext() {
    let vc = DoneViewController.instantiateStoryboard()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  // MARK: - Action
  @IBAction func tapRentButton(_ sender: Any) {
    Digits.sharedInstance().logOut()
    Digits.sharedInstance().authenticate { (session, error) in
      if (session != nil) {
        // TODO: associate the session userID with your user model
        let message = "Phone number: \(session!.phoneNumber)"
        print(message)
        self.segueForNext()
        Digits.sharedInstance().logOut()
      } else {
        NSLog("Authentication error: %@", error!.localizedDescription)
      }
    }
  }
  
}
