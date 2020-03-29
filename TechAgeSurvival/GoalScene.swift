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
    private var submitbutton: FTButtonNode!
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        self.submitbutton = self.childNode(withName: "//submitButton") as? FTButtonNode
        print(self.submitbutton)
        
        let buttonTextureSelected = SKTexture(imageNamed: "upicon_inverse.png")
        submitbutton.selectedTexture = buttonTextureSelected
        submitbutton.setButtonAction(
            target: self, triggerEvent: .TouchUpInside,
            action: #selector(self.submitonclick))
    }
    
    @objc func submitonclick(gender: Int) {
        nextScene()
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
