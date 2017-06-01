//
//  PrimitivesScene.swift
//  3DFirstTestApp
//
//  Created by Piotr Maleszczuk on 30.05.2017.
//  Copyright © 2017 Piotr Maleszczuk. All rights reserved.
//

import UIKit
import SceneKit

class PrimitivesScene: SCNScene {
    
    //board
    let diskRadius:CGFloat = 1.0
    var boardWidth:CGFloat = 0.0
    var boardLength:CGFloat = 0.0
    let boardPadding:CGFloat = 0.8
    let boardHeight:CGFloat = 0.2
    
    //leg
    let legWidth: CGFloat = 0.10
    let legLenght: CGFloat = 0.10
    var legHeight: CGFloat = 2.0
    
    //const
    var BOARD_WIDTH: CGFloat = 0.0
    var BOARD_LENGTH: CGFloat = 0.0
//    var BOARD_HEIGHT: CGFloat = 0.2
    let LEG_HEIGHT: CGFloat = 2.0
    
    //scene
    var board: SCNNode = SCNNode.init()
    var leftBackLeg: SCNNode = SCNNode.init()
    var leftFrontLeg: SCNNode = SCNNode.init()
    var rightBackLeg: SCNNode = SCNNode.init()
    var rightFrontLeg: SCNNode = SCNNode.init()
    var leftConnection: SCNNode = SCNNode.init()
    var rightConnection: SCNNode = SCNNode.init()
    var frontConnection: SCNNode = SCNNode.init()
    var backConnection: SCNNode = SCNNode.init()
    
    let mainNode = SCNNode.init()

    override init() {
        super.init()
//        let table = self.collada2SCNNode(filepath: "art.scnassets/table.dae")
//
//        //TABLE DAE work fine with obj file to
//        self.rootNode.addChildNode(table)
        
        //Table
        BOARD_WIDTH = (diskRadius * 6.0 + boardPadding)/2
        boardWidth = BOARD_WIDTH
        BOARD_LENGTH = (diskRadius * 2.0 + boardPadding)
        boardLength = BOARD_LENGTH
        
        let legY = -LEG_HEIGHT + legHeight/2
        let boardY = legY + legHeight/2 + boardHeight/2
        
        board = self.createBoard()
        board.position = SCNVector3.init(0.0, boardY, 0.0)
        
        leftBackLeg = self.createLeg()
        leftBackLeg.position = SCNVector3.init((-(self.boardWidth/2) + (legWidth/2)), legY, -(boardLength/2 - legLenght/2))
        
        leftFrontLeg = self.createLeg()
        leftFrontLeg.position = SCNVector3.init((-(self.boardWidth/2) + (legWidth/2)), legY, (boardLength/2 - legLenght/2))
        
        rightBackLeg = self.createLeg()
        rightBackLeg.position = SCNVector3.init(((self.boardWidth/2) - (legWidth/2)), legY, -(boardLength/2 - legLenght/2))
        
        rightFrontLeg = self.createLeg()
        rightFrontLeg.position = SCNVector3.init(((self.boardWidth/2) - (legWidth/2)), legY, (boardLength/2 - legLenght/2))
        
        leftConnection = self.createConnectionLeg(width: legWidth, height: legWidth, lenght: boardLength, chamferRadius: 0.0)
        leftConnection.position = SCNVector3.init((-(self.boardWidth/2) + (legWidth/2)), -(legHeight + legWidth/2), 0.0)
        
        rightConnection = self.createConnectionLeg(width: legWidth, height: legWidth, lenght: boardLength, chamferRadius: 0.0)
        rightConnection.position = SCNVector3.init(((self.boardWidth/2) - (legWidth/2)), -(legHeight + legWidth/2), 0.0)
        
        frontConnection = self.createConnectionLeg(width: boardWidth, height: legWidth, lenght: legWidth, chamferRadius: 0.0)
        frontConnection.position = SCNVector3.init(0.0, -(legHeight + legWidth/2), (boardLength/2 - legLenght/2))
        
        backConnection = self.createConnectionLeg(width: boardWidth, height: legWidth, lenght: legWidth, chamferRadius: 0.0)
        backConnection.position = SCNVector3.init(0.0, -(legHeight + legWidth/2), -(boardLength/2 - legLenght/2))
        mainNode.eulerAngles = SCNVector3.init(90*3.1417/180, 0, 0)

        rootNode.addChildNode(mainNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeScaleValue(width: CGFloat, height: CGFloat, lenght: CGFloat){
        self.board.scale = SCNVector3.init(width, 1.0, lenght)
        
        self.leftConnection.scale = SCNVector3.init(1.0, 1.0, lenght)
        self.rightConnection.scale = SCNVector3.init(1.0, 1.0, lenght)
        self.frontConnection.scale = SCNVector3.init(width, 1.0, 1.0)
        self.backConnection.scale = SCNVector3.init(width, 1.0, 1.0)
        
        self.boardWidth =  BOARD_WIDTH * width
        self.boardLength = BOARD_LENGTH * lenght
        
        self.leftBackLeg.scale = SCNVector3.init(1.0, height, 1.0)
        self.leftFrontLeg.scale = SCNVector3.init(1.0, height, 1.0)
        self.rightBackLeg.scale = SCNVector3.init(1.0, height, 1.0)
        self.rightFrontLeg.scale = SCNVector3.init(1.0, height, 1.0)
        self.legHeight = LEG_HEIGHT * height
        
        self.reloadPositions()
    }
    
    func changeBoardColor(color: UIColor){
        if color == UIColor.brown {
            let material_L = SCNMaterial()
            material_L.diffuse.contents = UIImage(named: "art.scnassets/texture.jpg")
            self.board.geometry?.materials = [material_L]
        } else {
            self.board.geometry?.firstMaterial?.diffuse.contents = color
        }
    }
    
    func reloadPositions(){
        let legY = -LEG_HEIGHT + legHeight/2
        let boardY = legY + legHeight/2 + boardHeight/2
        
        self.board.position = SCNVector3.init(0.0, boardY, 0.0)
        self.leftBackLeg.position = SCNVector3.init((-(self.boardWidth/2) + (legWidth/2)), legY, -(boardLength/2 - legLenght/2))
        self.leftFrontLeg.position = SCNVector3.init((-(self.boardWidth/2) + (legWidth/2)), legY, (boardLength/2 - legLenght/2))
        self.rightBackLeg.position = SCNVector3.init(((self.boardWidth/2) - (legWidth/2)), legY, -(boardLength/2 - legLenght/2))
        self.rightFrontLeg.position = SCNVector3.init(((self.boardWidth/2) - (legWidth/2)), legY, (boardLength/2 - legLenght/2))
        
        self.leftConnection.position = SCNVector3.init((-(self.boardWidth/2) + (legWidth/2)), CGFloat.init(self.frontConnection.position.y), 0.0)
        self.rightConnection.position = SCNVector3.init(((self.boardWidth/2) - (legWidth/2)), CGFloat.init(self.frontConnection.position.y), 0.0)
        self.frontConnection.position = SCNVector3.init(0.0, CGFloat.init(self.frontConnection.position.y), (boardLength/2 - legLenght/2))
        self.backConnection.position = SCNVector3.init(0.0, CGFloat.init(self.frontConnection.position.y), -(boardLength/2 - legLenght/2))
    }
    
    func createBoard() -> SCNNode {
        let boardGeometry = SCNBox(width: boardWidth, height: boardHeight, length: boardLength, chamferRadius: 0.02)
        
        let material_L = SCNMaterial()
        material_L.diffuse.contents = #imageLiteral(resourceName: "texture")
        boardGeometry.materials = [material_L]
        
        let boardNode = SCNNode(geometry: boardGeometry)
        mainNode.addChildNode(boardNode)
        return boardNode
    }
    
    func createLeg() -> SCNNode {
        let legGeometry = SCNBox(width: legWidth, height: legHeight, length: legLenght, chamferRadius: 0.0)
        legGeometry.firstMaterial?.diffuse.contents = UIColor.black
        
        let legNode = SCNNode(geometry: legGeometry)
//        legNode.eulerAngles = SCNVector3.init(90*3.1417/180, 0, 0)

        mainNode.addChildNode(legNode)
        return legNode
    }
    
    func createConnectionLeg(width: CGFloat, height: CGFloat, lenght: CGFloat, chamferRadius: CGFloat) -> SCNNode {
        let legGeometry = SCNBox(width: width, height: height, length: lenght, chamferRadius: chamferRadius)
        legGeometry.firstMaterial?.diffuse.contents = UIColor.black
        
        let legNode = SCNNode(geometry: legGeometry)
//        legNode.eulerAngles = SCNVector3.init(90*3.1417/180, 0, 0)
        mainNode.addChildNode(legNode)
        return legNode
    }
    
    func collada2SCNNode(filepath:String) -> SCNNode {
        let node = SCNNode()
        let scene = SCNScene(named: filepath)
        let nodeArray = scene!.rootNode.childNodes
        
        for childNode in nodeArray {
            node.addChildNode(childNode as SCNNode)
        }
        return node
    }
}

