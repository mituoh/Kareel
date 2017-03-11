//
//  CameraViewController.swift
//  Kareel
//
//  Created by Hironori Inagaki on 2017/03/11.
//  Copyright © 2017年 Hironori Inagaki. All rights reserved.
//

import UIKit
import AVFoundation

final class BookCaptureViewController: UIViewController, StoryboardInitializable {
  @IBOutlet weak var captureView: UIView!
  
  fileprivate lazy var captureSession: AVCaptureSession = AVCaptureSession()
  fileprivate lazy var captureDevice: AVCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
  
  fileprivate lazy var capturePreviewLayer: AVCaptureVideoPreviewLayer = {
    let layer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    return layer!
  }()
  
  fileprivate var captureInput: AVCaptureInput? = nil
  fileprivate lazy var captureOutput: AVCaptureMetadataOutput = {
    let output = AVCaptureMetadataOutput()
    output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    return output
  }()
  
  fileprivate var isCaptured = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    capturePreviewLayer.frame = self.captureView?.bounds ?? CGRect.zero
  }
  
  override func viewWillAppear(_ animated: Bool) {
    isCaptured = false
    setupBarcodeCapture()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    // カメラ停止 メモリ解放
    captureSession.stopRunning()
    
    for output in captureSession.outputs {
      captureSession.removeOutput(output as? AVCaptureOutput)
    }
    
    for input in captureSession.inputs {
      captureSession.removeInput(input as? AVCaptureInput)
    }
  }
  
  // MARK: - private

  private func setupBarcodeCapture() {
    do {
      captureInput = try AVCaptureDeviceInput(device: captureDevice)
      captureSession.addInput(captureInput)
      captureSession.addOutput(captureOutput)
      captureSession.sessionPreset = AVCaptureSessionPresetHigh
      captureOutput.metadataObjectTypes = captureOutput.availableMetadataObjectTypes
      capturePreviewLayer.frame = self.captureView?.bounds ?? CGRect.zero
      capturePreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
      captureView?.layer.addSublayer(capturePreviewLayer)
      captureSession.startRunning()
    } catch let error as NSError {
      print(error)
    }
  }
  
  fileprivate func segueForNext() {
    let vc = ConfirmViewController.instantiateStoryboard()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  // MARK: - Action
  
  @IBAction func tapCloseButton(_ sender: Any) {
    self.navigationController?.dismiss(animated: true, completion: nil)
  }
  
}

extension BookCaptureViewController: AVCaptureMetadataOutputObjectsDelegate {

  func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
    guard let objects = metadataObjects as? [AVMetadataObject] else { return }
    
    var detectionString: String? = nil
    let barcodeTypes = [AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code]
    
    for metadataObject in objects {
      loop: for type in barcodeTypes {
        guard metadataObject.type == type else { continue } // JANコードか判定
        self.captureSession.stopRunning()
        guard self.capturePreviewLayer.transformedMetadataObject(for: metadataObject) is AVMetadataMachineReadableCodeObject else { continue }
        
        if let object = metadataObject as? AVMetadataMachineReadableCodeObject {
          detectionString = object.stringValue
          break loop
        }
      }
      
      guard let value = detectionString else { continue }
      print("Read value:\t\(value)")
      guard let isbn = ISBN().convart(value: value) else { continue }
      print("ISBN:\t\(isbn)")
      
      if !isCaptured {
        Rent.shared.isbn = isbn
        segueForNext()
      }
      
      isCaptured = true
    }
    self.captureSession.startRunning()
  }
}
