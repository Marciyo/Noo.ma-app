//
//  ViewController.swift
//  VuforiaSample
//
//  Created by Yoshihiro Kato on 2016/07/02.
//  Copyright © 2016年 Yoshihiro Kato. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation
import SceneKit

class ViewController: UIViewController {
    
    let vuforiaLicenseKey = "AU4/QSb/////AAAAGXbC10H5gE8dnerT04qKY4kFF4zt5YhaM7ZBPEfTe/NRT6Evi5pv5NBgJz9jniZyFG74kYxeo66611SaAAcLo8FYteTecKrVjTtT+8GWnc5o+he51xhxrNcteASqZHBOUGlaiIf0GaRMueXnI5ZA6bExWaW7/Jai2zsBnfGVhVB0DAoTEpxbRFc9DOaYk49cMf4rIL1+86AelsOx1cErFbLbxbmL5TnitNjg0tK3RTHzpqpt6bNseUbwYjkK0v0CtdhWONgvH1n3xM0yXg5QKYnCIJ6emOnIK5gpePv9qWeU7/dl0JEAvTRMWj33+zOaxkS7ZgpgjrO2q/AYO1q0htG2Kn4mMc0PP6fb7tjrvDvm"
    let vuforiaDataSetFile = "StonesAndChips.xml"
    
    var vuforiaManager: VuforiaManager? = nil

    let widthSlider = UISlider.init()
    let lenghtSlider = UISlider.init()
    let heightSlider = UISlider.init()

    let sliderMaxValue: Float = 20
    
    let scnView = SCNView.init()

    fileprivate var lastSceneName: String? = nil

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepare()

        self.createUISliders()
        self.createUILogo()
        self.createUIButtons()
    }
    
    func createUISliders(){
        self.widthSlider.addTarget(self, action: #selector(self.widthChangeAction(sender:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(self.widthSlider)
        self.widthSlider.snp.makeConstraints { (item) in
            item.width.equalToSuperview().multipliedBy(0.8)
            item.centerX.equalToSuperview()
            item.bottom.equalToSuperview().offset(-50)
        }
        
        self.widthSlider.maximumValue = self.sliderMaxValue
        self.widthSlider.minimumValue = 1
        self.widthSlider.isContinuous = true
        
        let widthLabel = UILabel.init()
        widthLabel.text = "W:"
        self.view.addSubview(widthLabel)
        
        widthLabel.snp.makeConstraints { (item) in
            item.right.equalTo(self.widthSlider.snp.left).offset(-8)
            item.centerY.equalTo(self.widthSlider)
        }
        
        
        self.lenghtSlider.addTarget(self, action: #selector(self.lenghtChangeAction(sender:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(self.lenghtSlider)
        self.lenghtSlider.snp.makeConstraints { (item) in
            item.width.equalToSuperview().multipliedBy(0.8)
            item.centerX.equalToSuperview()
            item.bottom.equalTo(self.widthSlider).offset(-50)
        }
        
        self.lenghtSlider.maximumValue = self.sliderMaxValue
        self.lenghtSlider.minimumValue = 1
        self.lenghtSlider.isContinuous = true
        
        let lenghtLabel = UILabel.init()
        lenghtLabel.text = "L:"
        self.view.addSubview(lenghtLabel)
        lenghtLabel.snp.makeConstraints { (item) in
            item.right.equalTo(self.lenghtSlider.snp.left).offset(-8)
            item.centerY.equalTo(self.lenghtSlider)
        }
        
        self.heightSlider.addTarget(self, action: #selector(self.heightChangeAction(sender:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(self.heightSlider)
        self.heightSlider.snp.makeConstraints { (item) in
            item.width.equalToSuperview().multipliedBy(0.8)
            item.centerX.equalToSuperview()
            item.bottom.equalTo(self.lenghtSlider).offset(-50)
        }
        
        self.heightSlider.maximumValue = self.sliderMaxValue
        self.heightSlider.minimumValue = 1
        self.heightSlider.isContinuous = true
        
        let heightLabel = UILabel.init()
        heightLabel.text = "H:"
        self.view.addSubview(heightLabel)
        heightLabel.snp.makeConstraints { (item) in
            item.right.equalTo(self.heightSlider.snp.left).offset(-8)
            item.centerY.equalTo(self.heightSlider)
        }
    }
    
    func createUILogo(){
        
        let logoLabel = UILabel.init()
        logoLabel.text = "noo.ma"
        logoLabel.textColor = UIColor.black
        logoLabel.textAlignment = .right
        logoLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize + 10, weight: 8)
        self.view.addSubview(logoLabel)
        logoLabel.snp.makeConstraints { (item) in
            item.top.equalToSuperview().offset(30)
            item.right.equalToSuperview().offset(-30)
        }
        
        let logoBackground = UIView.init()
        logoBackground.backgroundColor = UIColor.white
        logoBackground.layer.cornerRadius = 8
        self.view.addSubview(logoBackground)
        self.view.bringSubview(toFront: logoLabel)
        logoBackground.snp.makeConstraints { (item) in
            item.centerX.equalTo(logoLabel)
            item.centerY.equalTo(logoLabel)
            item.height.equalTo(40)
            item.width.equalTo(110)
        }
    }
    
    func createUIButtons(){
        let buttonSize = 35
        let topButtonOffset = 30
        let leftButtonOffset = 15
        let betweenButtonsOffset = 15
        
        let brownButton = UIButton.init()
        brownButton.addTarget(self, action: #selector(self.changeColorAction(sender:)), for: UIControlEvents.touchUpInside)
        brownButton.backgroundColor = UIColor.brown
        brownButton.clipsToBounds = true
        brownButton.layer.cornerRadius = CGFloat(buttonSize/2)
        self.view.addSubview(brownButton)
        brownButton.snp.makeConstraints { (item) in
            item.height.width.equalTo(buttonSize)
            item.left.equalToSuperview().offset(leftButtonOffset)
            item.top.equalToSuperview().offset(topButtonOffset)
        }
        
        let grayButton = UIButton.init()
        grayButton.addTarget(self, action: #selector(self.changeColorAction(sender:)), for: UIControlEvents.touchUpInside)
        grayButton.backgroundColor = UIColor.lightGray
        grayButton.clipsToBounds = true
        grayButton.layer.cornerRadius = CGFloat(buttonSize/2)
        self.view.addSubview(grayButton)
        grayButton.snp.makeConstraints { (item) in
            item.height.width.equalTo(buttonSize)
            item.left.equalToSuperview().offset(leftButtonOffset)
            item.top.equalTo(brownButton.snp.bottom).offset(betweenButtonsOffset)
        }
        
        let blackButton = UIButton.init()
        blackButton.addTarget(self, action: #selector(self.changeColorAction(sender:)), for: UIControlEvents.touchUpInside)
        blackButton.backgroundColor = UIColor.black
        blackButton.clipsToBounds = true
        blackButton.layer.cornerRadius = CGFloat(buttonSize/2)
        self.view.addSubview(blackButton)
        blackButton.snp.makeConstraints { (item) in
            item.height.width.equalTo(buttonSize)
            item.left.equalToSuperview().offset(leftButtonOffset)
            item.top.equalTo(grayButton.snp.bottom).offset(betweenButtonsOffset)
        }
        
        let whiteButton = UIButton.init()
        whiteButton.addTarget(self, action: #selector(self.changeColorAction(sender:)), for: UIControlEvents.touchUpInside)
        whiteButton.backgroundColor = UIColor.white
        whiteButton.clipsToBounds = true
        whiteButton.layer.borderWidth = 1
        whiteButton.layer.borderColor = UIColor.black.cgColor
        whiteButton.layer.cornerRadius = CGFloat(buttonSize/2)
        self.view.addSubview(whiteButton)
        whiteButton.snp.makeConstraints { (item) in
            item.height.width.equalTo(buttonSize)
            item.left.equalToSuperview().offset(leftButtonOffset)
            item.top.equalTo(blackButton.snp.bottom).offset(betweenButtonsOffset)
        }
        
        let mButton = UIButton.init()
        mButton.addTarget(self, action: #selector(self.changeColorAction(sender:)), for: UIControlEvents.touchUpInside)
        mButton.backgroundColor = UIColor(red:0.94, green:0.77, blue:0.53, alpha:1.00)
        mButton.clipsToBounds = true
        mButton.layer.cornerRadius = CGFloat(buttonSize/2)
        self.view.addSubview(mButton)
        mButton.snp.makeConstraints { (item) in
            item.height.width.equalTo(buttonSize)
            item.left.equalToSuperview().offset(leftButtonOffset)
            item.top.equalTo(whiteButton.snp.bottom).offset(betweenButtonsOffset)
        }
    }
    
    func changeColorAction(sender: UIButton){
        if let scene = self.scnView.scene {
            let primitive = scene as! PrimitivesScene
            primitive.changeBoardColor(color: sender.backgroundColor!)
        }
    }
    
    func heightChangeAction(sender: UISlider){
        if let scene = self.scnView.scene {
            let primitive = scene as! PrimitivesScene
            primitive.changeScaleValue(width: CGFloat(self.widthSlider.value), height: CGFloat(sender.value), lenght: CGFloat(self.lenghtSlider.value))
        }
    }
    
    func widthChangeAction(sender: UISlider){
        if let scene = self.scnView.scene {
            let primitive = scene as! PrimitivesScene
            primitive.changeScaleValue(width: CGFloat(sender.value), height: CGFloat(self.heightSlider.value), lenght: CGFloat(self.lenghtSlider.value))
        }
    }
    
    func lenghtChangeAction(sender: UISlider){
        if let scene = self.scnView.scene {
            let primitive = scene as! PrimitivesScene
            primitive.changeScaleValue(width: CGFloat(self.widthSlider.value), height: CGFloat(self.heightSlider.value), lenght: CGFloat(sender.value))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        do {
            try vuforiaManager?.stop()
        }catch let error {
            print("\(error)")
        }
    }
}

private extension ViewController {
    func prepare() {
        vuforiaManager = VuforiaManager(licenseKey: vuforiaLicenseKey, dataSetFile: vuforiaDataSetFile)
        if let manager = vuforiaManager {
            manager.delegate = self
            manager.eaglView.sceneSource = self
            manager.eaglView.delegate = self
            manager.eaglView.setupRenderer()
            self.view = manager.eaglView
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(didRecieveWillResignActiveNotification),
                                       name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(didRecieveDidBecomeActiveNotification),
                                       name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        vuforiaManager?.prepare(with: .portrait)
    }
    
    func pause() {
        do {
            try vuforiaManager?.pause()
        }catch let error {
            print("\(error)")
        }
    }
    
    func resume() {
        do {
            try vuforiaManager?.resume()
        }catch let error {
            print("\(error)")
        }
    }
}

extension ViewController {
    func didRecieveWillResignActiveNotification(_ notification: Notification) {
        pause()
    }
    
    func didRecieveDidBecomeActiveNotification(_ notification: Notification) {
        resume()
    }
}

extension ViewController: VuforiaManagerDelegate {
    func vuforiaManagerDidFinishPreparing(_ manager: VuforiaManager!) {
        print("did finish preparing\n")
        
        do {
            try vuforiaManager?.start()
            vuforiaManager?.setContinuousAutofocusEnabled(true)
        }catch let error {
            print("\(error)")
        }
    }
    
    func vuforiaManager(_ manager: VuforiaManager!, didFailToPreparingWithError error: Error!) {
        print("did faid to preparing \(error)\n")
    }
    
    func vuforiaManager(_ manager: VuforiaManager!, didUpdateWith state: VuforiaState!) {
        for index in 0 ..< state.numberOfTrackableResults {
            let result = state.trackableResult(at: index)
            let trackerableName = result?.trackable.name
            //            print("\(trackerableName)")
            if trackerableName == "stones" {
                if lastSceneName != "stones" {
                    manager.eaglView.setNeedsChangeSceneWithUserInfo(["scene" : "stones"])
                    lastSceneName = "stones"
                }
            }
        }
    }
}

extension ViewController: VuforiaEAGLViewSceneSource, VuforiaEAGLViewDelegate {
    
    func scene(for view: VuforiaEAGLView!, userInfo: [String : Any]?) -> SCNScene! {
        return createStonesScene(with: view)
    }
    
    fileprivate func createStonesScene(with view: VuforiaEAGLView) -> SCNScene {
        self.scnView.scene = PrimitivesScene.init()
        self.scnView.autoenablesDefaultLighting = true
        self.scnView.allowsCameraControl = false
        return self.scnView.scene!
    }
    
    func vuforiaEAGLView(_ view: VuforiaEAGLView!, didTouchDownNode node: SCNNode!) {
        print("touch down \(node.name ?? "")")
    }
    
    func vuforiaEAGLView(_ view: VuforiaEAGLView!, didTouchUp node: SCNNode!) {
        print("touch up \(node.name ?? "")")
    }
    
    func vuforiaEAGLView(_ view: VuforiaEAGLView!, didTouchCancel node: SCNNode!) {
        print("touch cancel \(node.name ?? "")")
    }
}
