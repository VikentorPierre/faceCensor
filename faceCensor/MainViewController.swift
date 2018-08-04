//
//  ViewController.swift
//  faceCensor
//
//  Created by Vikentor Pierre on 8/4/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyCam

class MainViewController: SwiftyCamViewController {
    
    //var captureButton: SwiftyCamButton = SwiftyCamButton()
    let flashButton:UIButton = {
        let obj = UIButton()
        obj.setImage(UIImage(imageLiteralResourceName: "flashOutline"), for: .normal)
        obj.addTarget(self, action: #selector(toggleFlash), for: .touchUpInside)
        return obj
    }()
    
    let takeButton:UIButton = {
        let obj = UIButton()
        obj.backgroundColor = .white
        obj.layer.cornerRadius = 30
        obj.clipsToBounds = true
        obj.addTarget(self, action: #selector(shootButton), for: .touchUpInside)
        return obj
    }()
    
    let cameraSwitchfunc:UIButton = {
        let obj = UIButton()
        obj.setImage(UIImage(named: "CameraSwitch"), for: .normal)
        obj.addTarget(self, action: #selector(toggleCamera), for: .touchUpInside)
        return obj
        
    }()
    
    let segmentedController:UISegmentedControl = {
        let obj = UISegmentedControl(items: ["Photo","Video"])
        obj.selectedSegmentIndex = 0
        obj.tintColor = .white
        //obj.addTarget(self, action: #selector(segment), for: .touchUpInside)
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraDelegate = self
        defaultCamera = .rear
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //takeButton.delegate = self
    }
    override func loadView() {
        super.loadView()
        setuplayout()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    fileprivate func setuplayout(){
        //self.backgroundColor = .black
        //self.view.addSubview(captureButton)
        self.view.addSubview(takeButton)
        self.view.addSubview(flashButton)
        self.view.addSubview(segmentedController)
        self.view.addSubview(cameraSwitchfunc)
        //self.view.insertSubview(takeButton, at: 1)
        takeButton.snp.makeConstraints { (make) in
            make.centerXWithinMargins.equalToSuperview()
            make.size.equalTo(60)
            make.bottom.equalTo(-5)
        }
        segmentedController.snp.makeConstraints { (make) in
            make.leadingMargin.equalTo(0)
            make.bottomMargin.equalTo(-27)
        }
        cameraSwitchfunc.snp.makeConstraints { (make) in
            make.trailingMargin.equalTo(-20)
            make.bottomMargin.equalTo(-27)
        }
        
        flashButton.snp.makeConstraints { (make) in
            make.topMargin.equalTo(15)
            make.trailingMargin.equalTo(-15)
        }
        
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        let newVC = PhotoPreviewVC(image: photo)
        self.present(newVC, animated: true, completion: nil)
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        print(zoom)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        print(camera)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error) {
        print(error)
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        let newVC = VideoPreviewVC(videoURL: url)
        self.present(newVC, animated: true, completion: nil)
    }
    
    @objc func shootButton(sender:UIButton){
        if segmentedController.selectedSegmentIndex == 0 {
            // take photo
            takePhoto()
        }
        else if (segmentedController.selectedSegmentIndex == 1){
            print(segmentedController.selectedSegmentIndex)
            if !isVideoRecording{
                startVideoRecording()
            }else{ stopVideoRecording()}
        }
    }
    @objc func toggleCamera(){
        switchCamera()
    }
    @objc func toggleFlash(){
        
        flashEnabled = !flashEnabled
        
        if flashEnabled == true {
            flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControlState())
        } else {
            flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControlState())
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension MainViewController : SwiftyCamViewControllerDelegate{
    
    
    
}

