//
//  GameScene.swift
//  TechAgeSurvival
//
//  Created by Thera on 3/27/20.
//  Copyright © 2020 Skygazers. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var eyevalue : SKLabelNode!
    private var dietvalue : SKLabelNode!
    private var fitnessvalue : SKLabelNode!
    private var healthvalue : SKLabelNode!
    private var happinessvalue : SKLabelNode!
    
    override func sceneDidLoad() {
//        self.eyevalue.run(SKAction.fadeIn(withDuration: 2.0))

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.eyevalue = self.childNode(withName: "//EyeValue") as? SKLabelNode
        self.eyevalue.text = "0"
        
        self.dietvalue = self.childNode(withName: "//DietValue") as? SKLabelNode
        self.dietvalue.text = "0"
        
        self.fitnessvalue = self.childNode(withName: "//FitnessValue") as? SKLabelNode
        self.fitnessvalue.text = "0"
        
        self.healthvalue = self.childNode(withName: "//HealthValue") as? SKLabelNode
        self.healthvalue.text = "0"
        
        self.happinessvalue = self.childNode(withName: "//HappinessValue") as? SKLabelNode
        self.happinessvalue.text = "0"
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
