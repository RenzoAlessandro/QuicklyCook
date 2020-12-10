//
//  RealTimeCameraObjectDetectionViewController.swift
//  QuicklyCook
//
//  Created by Renzo Alessandro on 11/19/19.
//  Copyright © 2019 Renzo Alessandro. All rights reserved.
//

import UIKit
import AVKit
import Vision

class RealTimeCameraObjectDetectionViewController: UIViewController , AVCaptureVideoDataOutputSampleBufferDelegate{
    
    @IBOutlet weak var TextoDeteccion: UILabel!
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    let captureSession = AVCaptureSession()
    
    captureSession.sessionPreset = .photo

    guard let captureDevice = AVCaptureDevice.default(for: .video) else{return}
    
    guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {return}
    
    captureSession.addInput(input)
    
    captureSession.startRunning()
    
    let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    
    view.layer.addSublayer(previewLayer)
    
    previewLayer.frame = view.frame
    
    let dataOutput = AVCaptureVideoDataOutput()
    dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
    captureSession.addOutput(dataOutput)
    

    
}

func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    //print("Camera was able to capture a frame:", Data())
    
    guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else{return}
    
    guard let model = try? VNCoreMLModel(for: SqueezeNet().model)else{return}
    
    let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
        guard let results = finishedReq.results as? [VNClassificationObservation]else{return}
        guard let firstOservation = results.first else{return}
        
        print(firstOservation.identifier,firstOservation.confidence)
        
        DispatchQueue.main.async {
            self.TextoDeteccion.text = "\(firstOservation.identifier)"
            //self.TextoDeteccion.text = "\(firstOservation.identifier) \(firstOservation.confidence * 100)"
        }
        
    }
    
    try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    
}

}
