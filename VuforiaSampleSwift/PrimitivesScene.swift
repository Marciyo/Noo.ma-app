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
//        //TABLE DAE work fine with obj file to
//        self.rootNode.addChildNode(table)
        
        //Table
        self.createTable()

        rootNode.addChildNode(self.mainNode)
    }
    
    func createTable(){
        self.BOARD_WIDTH = (self.diskRadius * 6.0 + self.boardPadding)/2
        self.boardWidth = self.BOARD_WIDTH
        self.BOARD_LENGTH = (self.diskRadius * 2.0 + self.boardPadding)
        self.boardLength = self.BOARD_LENGTH
        
        let legY = -self.LEG_HEIGHT + self.legHeight/2
        let boardY = legY + self.legHeight/2 + self.boardHeight/2
        
        self.board = self.createBoard()
        self.board.position = SCNVector3.init(0.0, boardY, 0.0)
        
        self.leftBackLeg = self.createLeg()
        self.leftBackLeg.position = SCNVector3.init((-(self.boardWidth/2) + (self.legWidth/2)), legY, -(self.boardLength/2 - self.legLenght/2))
        
        self.leftFrontLeg = self.createLeg()
        self.leftFrontLeg.position = SCNVector3.init((-(self.boardWidth/2) + (self.legWidth/2)), legY, (self.boardLength/2 - self.legLenght/2))
        
        self.rightBackLeg = self.createLeg()
        self.rightBackLeg.position = SCNVector3.init(((self.boardWidth/2) - (self.legWidth/2)), legY, -(self.boardLength/2 - self.legLenght/2))
        
        self.rightFrontLeg = self.createLeg()
        self.rightFrontLeg.position = SCNVector3.init(((self.boardWidth/2) - (self.legWidth/2)), legY, (self.boardLength/2 - self.legLenght/2))
        
        self.leftConnection = self.createConnectionLeg(width: self.legWidth, height: self.legWidth, lenght: self.boardLength, chamferRadius: 0.0)
        self.leftConnection.position = SCNVector3.init((-(self.boardWidth/2) + (self.legWidth/2)), -(self.legHeight + self.legWidth/2), 0.0)
        
        self.rightConnection = self.createConnectionLeg(width: self.legWidth, height: legWidth, lenght: boardLength, chamferRadius: 0.0)
        self.rightConnection.position = SCNVector3.init(((self.boardWidth/2) - (self.legWidth/2)), -(self.legHeight + self.legWidth/2), 0.0)
        
        self.frontConnection = self.createConnectionLeg(width: self.boardWidth, height: self.legWidth, lenght: self.legWidth, chamferRadius: 0.0)
        self.frontConnection.position = SCNVector3.init(0.0, -(self.legHeight + legWidth/2), (self.boardLength/2 - self.legLenght/2))
        
        self.backConnection = self.createConnectionLeg(width: self.boardWidth, height: self.legWidth, lenght: self.legWidth, chamferRadius: 0.0)
        self.backConnection.position = SCNVector3.init(0.0, -(self.legHeight + self.legWidth/2), -(self.boardLength/2 - self.legLenght/2))
        self.mainNode.eulerAngles = SCNVector3.init(90*3.1417/180, 0, 0)
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
        
        self.boardWidth =  self.BOARD_WIDTH * width
        self.boardLength = self.BOARD_LENGTH * lenght
        
        self.leftBackLeg.scale = SCNVector3.init(1.0, height, 1.0)
        self.leftFrontLeg.scale = SCNVector3.init(1.0, height, 1.0)
        self.rightBackLeg.scale = SCNVector3.init(1.0, height, 1.0)
        self.rightFrontLeg.scale = SCNVector3.init(1.0, height, 1.0)
        self.legHeight = self.LEG_HEIGHT * height
        
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
        let legY = -self.LEG_HEIGHT + self.legHeight/2
        let boardY = legY + self.legHeight/2 + self.boardHeight/2
        
        self.board.position = SCNVector3.init(0.0, boardY, 0.0)
        self.leftBackLeg.position = SCNVector3.init((-(self.boardWidth/2) + (self.legWidth/2)), legY, -(self.boardLength/2 - self.legLenght/2))
        self.leftFrontLeg.position = SCNVector3.init((-(self.boardWidth/2) + (self.legWidth/2)), legY, (self.boardLength/2 - self.legLenght/2))
        self.rightBackLeg.position = SCNVector3.init(((self.boardWidth/2) - (self.legWidth/2)), legY, -(self.boardLength/2 - self.legLenght/2))
        self.rightFrontLeg.position = SCNVector3.init(((self.boardWidth/2) - (self.legWidth/2)), legY, (self.boardLength/2 - self.legLenght/2))
        
        self.leftConnection.position = SCNVector3.init((-(self.boardWidth/2) + (self.legWidth/2)), CGFloat.init(self.frontConnection.position.y), 0.0)
        self.rightConnection.position = SCNVector3.init(((self.boardWidth/2) - (self.legWidth/2)), CGFloat.init(self.frontConnection.position.y), 0.0)
        self.frontConnection.position = SCNVector3.init(0.0, CGFloat.init(self.frontConnection.position.y), (self.boardLength/2 - self.legLenght/2))
        self.backConnection.position = SCNVector3.init(0.0, CGFloat.init(self.frontConnection.position.y), -(self.boardLength/2 - self.legLenght/2))
    }
    
    func createBoard() -> SCNNode {
        let boardGeometry = SCNBox(width: self.boardWidth, height: self.boardHeight, length: self.boardLength, chamferRadius: 0.02)
        
        let material_L = SCNMaterial()
        material_L.diffuse.contents = #imageLiteral(resourceName: "texture")
        boardGeometry.materials = [material_L]
        
        let boardNode = SCNNode(geometry: boardGeometry)
        self.mainNode.addChildNode(boardNode)
        return boardNode
    }
    
    func createLeg() -> SCNNode {
        let legGeometry = SCNBox(width: self.legWidth, height: self.legHeight, length: self.legLenght, chamferRadius: 0.0)
        legGeometry.firstMaterial?.diffuse.contents = UIColor.black
        let legNode = SCNNode(geometry: legGeometry)
        self.mainNode.addChildNode(legNode)
        return legNode
    }
    
    func createConnectionLeg(width: CGFloat, height: CGFloat, lenght: CGFloat, chamferRadius: CGFloat) -> SCNNode {
        let legGeometry = SCNBox(width: width, height: height, length: lenght, chamferRadius: chamferRadius)
        legGeometry.firstMaterial?.diffuse.contents = UIColor.black
        let legNode = SCNNode(geometry: legGeometry)
        self.mainNode.addChildNode(legNode)
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
