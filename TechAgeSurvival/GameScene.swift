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
    
    private let date = NSDate()
    private var lastUpdateTime : TimeInterval = 0
    
    private var eyelabel : SKLabelNode!
    private var dietlabel : SKLabelNode!
    private var fitnesslabel : SKLabelNode!
    private var healthlabel : SKLabelNode!
    private var happinesslabel : SKLabelNode!
    
    private var eyebar : SKSpriteNode!
    private var dietbar : SKSpriteNode!
    private var fitnessbar : SKSpriteNode!
    private var healthbar : SKSpriteNode!
    private var happinessbar : SKSpriteNode!
    
    private var eyevalue : CGFloat = 100
    private var dietvalue : CGFloat = 70
    private var fitnessvalue : CGFloat = 50
    private var healthvalue : CGFloat = 30
    private var happinessvalue : CGFloat = 10
    
    private let progressBarSize: CGFloat = 200
    
    override func sceneDidLoad() {
//        self.eyevalue.run(SKAction.fadeIn(withDuration: 2.0))

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.eyelabel = self.childNode(withName: "//EyeValue") as? SKLabelNode
        self.dietlabel = self.childNode(withName: "//DietValue") as? SKLabelNode
        self.fitnesslabel = self.childNode(withName: "//FitnessValue") as? SKLabelNode
        self.healthlabel = self.childNode(withName: "//HealthValue") as? SKLabelNode
        self.happinesslabel = self.childNode(withName: "//HappinessValue") as? SKLabelNode
        
        self.eyebar = self.childNode(withName: "//EyeBar") as? SKSpriteNode
        self.dietbar = self.childNode(withName: "//DietBar") as? SKSpriteNode
        self.fitnessbar = self.childNode(withName: "//FitnessBar") as? SKSpriteNode
        self.healthbar = self.childNode(withName: "//HealthBar") as? SKSpriteNode
        self.happinessbar = self.childNode(withName: "//HappinessBar") as? SKSpriteNode
        
    }
    
    func valueToColor(_ value: CGFloat) -> UIColor {
        return UIColor(red: (1 - value / 100) * 2,
                       green: value / 100 * 2,
                       blue: 0, alpha: 1.0)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        self.eyelabel.text = String(Int(self.eyevalue))
        self.dietlabel.text = String(Int(self.dietvalue))
        self.fitnesslabel.text = String(Int(self.fitnessvalue))
        self.healthlabel.text = String(Int(self.healthvalue))
        self.happinesslabel.text = String(Int(self.happinessvalue))
        
        self.eyebar.size.width = self.eyevalue / 100 * self.progressBarSize
        self.dietbar.size.width = self.dietvalue / 100 * self.progressBarSize
        self.fitnessbar.size.width = self.fitnessvalue / 100 * self.progressBarSize
        self.healthbar.size.width = self.healthvalue / 100 * self.progressBarSize
        self.happinessbar.size.width = self.happinessvalue / 100 * self.progressBarSize
        
        self.eyebar.color = valueToColor(self.eyevalue)
        self.dietbar.color = valueToColor(self.dietvalue)
        self.fitnessbar.color = valueToColor(self.fitnessvalue)
        self.healthbar.color = valueToColor(self.healthvalue)
        self.happinessbar.color = valueToColor(self.happinessvalue)
        print(self.happinessbar.color)

        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
