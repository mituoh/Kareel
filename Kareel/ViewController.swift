//
//  ViewController.swift
//  Kareel
//
//  Created by Hironori Inagaki on 2017/03/11.
//  Copyright © 2017年 Hironori Inagaki. All rights reserved.
//

import UIKit
import DigitsKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let authButton = DGTAuthenticateButton(authenticationCompletion: { (session, error) in
      if (session != nil) {
        // TODO: associate the session userID with your user model
        let message = "Phone number: \(session!.phoneNumber)"
        let alertController = UIAlertController(title: "You are logged in!", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: .none))
        self.present(alertController, animated: true, completion: .none)
      } else {
        NSLog("Authentication error: %@", error!.localizedDescription)
      }
    })
    authButton?.center = self.view.center
    self.view.addSubview(authButton!)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

