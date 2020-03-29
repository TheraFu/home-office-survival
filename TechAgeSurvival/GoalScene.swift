//
//  StartScene.swift
//  TechAgeSurvival
//
//  Created by Thera on 3/28/20.
//  Copyright © 2020 Skygazers. All rights reserved.
//

import SpriteKit
import GameplayKit

class GoalScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var goalLabel: SKLabelNode!
    private var submitbutton: FTButtonNode!
    private var upbutton: FTButtonNode!
    private var downbutton: FTButtonNode!
    
    private var goalInt: Int = 8000

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        self.submitbutton = self.childNode(withName: "//submitButton") as? FTButtonNode
        self.goalLabel = self.childNode(withName: "//goalNumber") as? SKLabelNode
        
        let submitButtonSelected = SKTexture(imageNamed: "submitButton_inv.png")
        submitbutton.selectedTexture = submitButtonSelected
        submitbutton.setButtonAction(
            target: self, triggerEvent: .TouchUpInside,
            action: #selector(self.submitonclick))
        
        self.upbutton = self.childNode(withName: "//upbutton") as? FTButtonNode
        let arrowButtonSelected = SKTexture(imageNamed: "upicon_inverse.png")
        upbutton.selectedTexture = arrowButtonSelected
        upbutton.setButtonAction(
            target: self, triggerEvent: .TouchUpInside,
            action: #selector(self.uponclick))
        
        self.downbutton = self.childNode(withName: "//downbutton") as? FTButtonNode
        downbutton.selectedTexture = arrowButtonSelected
        downbutton.setButtonAction(
            target: self, triggerEvent: .TouchUpInside,
            action: #selector(self.downonclick))
        updateLabel()
    }
    
    private func updateLabel() {
        goalLabel.text = String(goalInt)
    }
    
    @objc func submitonclick(gender: Int) {
        nextScene()
    }
    
    @objc func uponclick(gender: Int) {
        goalInt += 1000
        updateLabel()
    }
    
    @objc func downonclick(gender: Int) {
        if (goalInt >= 1000) {
            goalInt -= 1000
            updateLabel()
        }
    }
    
    private func nextScene() {
        let nextGameScene = GameScene(fileNamed: "GameScene")!
        self.scene?.view?.presentScene(nextGameScene, transition: SKTransition.moveIn(with: SKTransitionDirection.right, duration: 0.5))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime

        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
    }
}
