//
//  ViewController.swift
//  VuforiaSample
//
//  Created by Yoshihiro Kato on 2016/07/02.
//  Copyright © 2016年 Yoshihiro Kato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let vuforiaLicenseKey = "AU4/QSb/////AAAAGXbC10H5gE8dnerT04qKY4kFF4zt5YhaM7ZBPEfTe/NRT6Evi5pv5NBgJz9jniZyFG74kYxeo66611SaAAcLo8FYteTecKrVjTtT+8GWnc5o+he51xhxrNcteASqZHBOUGlaiIf0GaRMueXnI5ZA6bExWaW7/Jai2zsBnfGVhVB0DAoTEpxbRFc9DOaYk49cMf4rIL1+86AelsOx1cErFbLbxbmL5TnitNjg0tK3RTHzpqpt6bNseUbwYjkK0v0CtdhWONgvH1n3xM0yXg5QKYnCIJ6emOnIK5gpePv9qWeU7/dl0JEAvTRMWj33+zOaxkS7ZgpgjrO2q/AYO1q0htG2Kn4mMc0PP6fb7tjrvDvm"
    let vuforiaDataSetFile = "StonesAndChips.xml"
    
    var vuforiaManager: VuforiaManager? = nil

    let widthSlider = UISlider.init()
    let lenghtSlider = UISlider.init()
    let heightSlider = UISlider.init()

    
    let boxMaterial = SCNMaterial()
    let boxNode = SCNNode()

    fileprivate var lastSceneName: String? = nil
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepare()
        
        self.widthSlider.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.widthSlider)
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.widthSlider,
                    attribute: NSLayoutAttribute.width,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.width,
                    multiplier: 0.8,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.widthSlider,
                    attribute: NSLayoutAttribute.centerX,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.centerX,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.widthSlider,
                    attribute: NSLayoutAttribute.bottom,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.bottom,
                    multiplier: 1.0,
                    constant: -50
                )
            ]
        )
        
        self.widthSlider.maximumValue = 20
        self.widthSlider.minimumValue = 1
        self.widthSlider.isContinuous = true
        
        let widthLabel = UILabel.init()
        widthLabel.translatesAutoresizingMaskIntoConstraints = false
        widthLabel.text = "W:"
        self.view.addSubview(widthLabel)
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: widthLabel,
                    attribute: NSLayoutAttribute.right,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.widthSlider,
                    attribute: NSLayoutAttribute.left,
                    multiplier: 1.0,
                    constant: -8
                ),
                NSLayoutConstraint.init(
                    item: widthLabel,
                    attribute: NSLayoutAttribute.centerY,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.widthSlider,
                    attribute: NSLayoutAttribute.centerY,
                    multiplier: 1.0,
                    constant: 0
                )
            ]
        )
        
        self.lenghtSlider.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.lenghtSlider)
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.lenghtSlider,
                    attribute: NSLayoutAttribute.width,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.width,
                    multiplier: 0.8,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.lenghtSlider,
                    attribute: NSLayoutAttribute.centerX,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.centerX,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.lenghtSlider,
                    attribute: NSLayoutAttribute.bottom,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.widthSlider,
                    attribute: NSLayoutAttribute.bottom,
                    multiplier: 1.0,
                    constant: -50
                )
            ]
        )
        
        self.lenghtSlider.maximumValue = 20
        self.lenghtSlider.minimumValue = 1
        self.lenghtSlider.isContinuous = true
        
        let lenghtLabel = UILabel.init()
        lenghtLabel.translatesAutoresizingMaskIntoConstraints = false
        lenghtLabel.text = "L:"
        self.view.addSubview(lenghtLabel)
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: lenghtLabel,
                    attribute: NSLayoutAttribute.right,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.lenghtSlider,
                    attribute: NSLayoutAttribute.left,
                    multiplier: 1.0,
                    constant: -8
                ),
                NSLayoutConstraint.init(
                    item: lenghtLabel,
                    attribute: NSLayoutAttribute.centerY,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.lenghtSlider,
                    attribute: NSLayoutAttribute.centerY,
                    multiplier: 1.0,
                    constant: 0
                )
            ]
        )
        
        self.heightSlider.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.heightSlider)
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: self.heightSlider,
                    attribute: NSLayoutAttribute.width,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.width,
                    multiplier: 0.8,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.heightSlider,
                    attribute: NSLayoutAttribute.centerX,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.centerX,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: self.heightSlider,
                    attribute: NSLayoutAttribute.bottom,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.lenghtSlider,
                    attribute: NSLayoutAttribute.bottom,
                    multiplier: 1.0,
                    constant: -50
                )
            ]
        )
        self.heightSlider.maximumValue = 20
        self.heightSlider.minimumValue = 1
        self.heightSlider.isContinuous = true
        
        let heightLabel = UILabel.init()
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.text = "H:"
        self.view.addSubview(heightLabel)
        self.view.addConstraints(
            [
                NSLayoutConstraint.init(
                    item: heightLabel,
                    attribute: NSLayoutAttribute.right,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.heightSlider,
                    attribute: NSLayoutAttribute.left,
                    multiplier: 1.0,
                    constant: -8
                ),
                NSLayoutConstraint.init(
                    item: heightLabel,
                    attribute: NSLayoutAttribute.centerY,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self.heightSlider,
                    attribute: NSLayoutAttribute.centerY,
                    multiplier: 1.0,
                    constant: 0
                )
            ]
        )
        
        boxNode.name = "box"
        boxNode.geometry = SCNBox(width:1, height:1, length:1, chamferRadius:0.0)
        boxNode.geometry?.firstMaterial = boxMaterial
        
        _ = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    func update(){
        boxNode.position.z = (self.heightSlider.value / 2) - 1
        boxNode.geometry = SCNBox(width: CGFloat.init(self.widthSlider.value), height:CGFloat.init(self.lenghtSlider.value), length:CGFloat.init(self.heightSlider.value), chamferRadius:0.0)
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
                boxMaterial.diffuse.contents = UIColor.red
                
                if lastSceneName != "stones" {
                    manager.eaglView.setNeedsChangeSceneWithUserInfo(["scene" : "stones"])
                    lastSceneName = "stones"
                }
            }else {
                boxMaterial.diffuse.contents = UIColor.blue
                
                if lastSceneName != "chips" {
                    manager.eaglView.setNeedsChangeSceneWithUserInfo(["scene" : "chips"])
                    lastSceneName = "chips"
                }
            }
            
        }
    }
}

extension ViewController: VuforiaEAGLViewSceneSource, VuforiaEAGLViewDelegate {
    
    func scene(for view: VuforiaEAGLView!, userInfo: [String : Any]?) -> SCNScene! {
        guard let userInfo = userInfo else {
            print("default scene")
            return createStonesScene(with: view)
        }
        
        if let sceneName = userInfo["scene"] as? String , sceneName == "stones" {
            print("stones scene")
            return createStonesScene(with: view)
        }else {
            print("chips scene")
            return createChipsScene(with: view)
        }
        
    }
    
    fileprivate func createStonesScene(with view: VuforiaEAGLView) -> SCNScene {
        let scene = SCNScene()
        
        boxMaterial.diffuse.contents = UIColor.lightGray
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.light?.color = UIColor.lightGray
        lightNode.position = SCNVector3(x:0, y:10, z:10)
        scene.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        let planeNode = SCNNode()
        planeNode.name = "plane"
        planeNode.geometry = SCNPlane(width: 247.0*view.objectScale, height: 173.0*view.objectScale)
        planeNode.position = SCNVector3Make(0, 0, -1)
        let planeMaterial = SCNMaterial()
        planeMaterial.diffuse.contents = UIColor.green
        planeMaterial.transparency = 0.6
        planeNode.geometry?.firstMaterial = planeMaterial
        scene.rootNode.addChildNode(planeNode)

        scene.rootNode.addChildNode(boxNode)
        
        return scene
    }
    
    fileprivate func createChipsScene(with view: VuforiaEAGLView) -> SCNScene {
        let scene = SCNScene()
        
        boxMaterial.diffuse.contents = UIColor.lightGray
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.light?.color = UIColor.lightGray
        lightNode.position = SCNVector3(x:0, y:10, z:10)
        scene.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        let planeNode = SCNNode()
        planeNode.name = "plane"
        planeNode.geometry = SCNPlane(width: 247.0*view.objectScale, height: 173.0*view.objectScale)
        planeNode.position = SCNVector3Make(0, 0, -1)
        let planeMaterial = SCNMaterial()
        planeMaterial.diffuse.contents = UIColor.red
        planeMaterial.transparency = 0.6
        planeNode.geometry?.firstMaterial = planeMaterial
        scene.rootNode.addChildNode(planeNode)
        
        let boxNode = SCNNode()
        boxNode.name = "box"
        boxNode.geometry = SCNBox(width:1, height:1, length:1, chamferRadius:0.0)
        boxNode.geometry?.firstMaterial = boxMaterial
        scene.rootNode.addChildNode(boxNode)
        
        return scene
    }
    
    func vuforiaEAGLView(_ view: VuforiaEAGLView!, didTouchDownNode node: SCNNode!) {
        print("touch down \(node.name ?? "")")
        boxMaterial.transparency = 0.6
        boxMaterial.diffuse.contents = #imageLiteral(resourceName: "Plik113 2")
        boxMaterial.isDoubleSided = true
    }
    
    func vuforiaEAGLView(_ view: VuforiaEAGLView!, didTouchUp node: SCNNode!) {
        print("touch up \(node.name ?? "")")
        boxMaterial.transparency = 1.0
    }
    
    func vuforiaEAGLView(_ view: VuforiaEAGLView!, didTouchCancel node: SCNNode!) {
        print("touch cancel \(node.name ?? "")")
        boxMaterial.transparency = 1.0
    }
}

