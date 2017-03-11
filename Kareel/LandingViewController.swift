//
//  ViewController.swift
//  Kareel
//
//  Created by Hironori Inagaki on 2017/03/11.
//  Copyright © 2017年 Hironori Inagaki. All rights reserved.
//

import UIKit

final class LandingViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Action

  @IBAction func tapRentButton(_ sender: Any) {
    let vc = BookCaptureViewController.instantiateStoryboard()
    let nc = UINavigationController(rootViewController: vc)
    self.present(nc, animated: true, completion: nil)
  }
  
  @IBAction func tapReturnButton(_ sender: Any) {
  }
  
  @IBAction func tapStatusButton(_ sender: Any) {
  }

}

