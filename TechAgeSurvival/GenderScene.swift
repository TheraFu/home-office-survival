//
//  StartScene.swift
//  TechAgeSurvival
//
//  Created by Thera on 3/28/20.
//  Copyright © 2020 Skygazers. All rights reserved.
//

import SpriteKit
import GameplayKit

class GenderScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var malebutton: FTButtonNode!
    private var femalebutton: FTButtonNode!
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        self.malebutton = self.childNode(withName: "//maleButton") as? FTButtonNode
        self.femalebutton = self.childNode(withName: "//femaleButton") as? FTButtonNode
        
        let buttonTextureSelected = SKTexture(imageNamed: "upicon_inverse.png")
        malebutton.selectedTexture = buttonTextureSelected
        femalebutton.selectedTexture = buttonTextureSelected
        malebutton.setButtonAction(
            target: self, triggerEvent: .TouchUpInside,
            action: #selector(self.updategenderMale))
        femalebutton.setButtonAction(
            target: self, triggerEvent: .TouchUpInside,
            action: #selector(self.updategenderFemale))
    }
    
    @objc func updategenderMale(gender: Int) {
        nextScene()
    }
    
    @objc func updategenderFemale(gender: Int) {
        nextScene()
    }
    
    private func nextScene() {
        let nextGameScene = GoalScene(fileNamed: "GoalScene")!
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
