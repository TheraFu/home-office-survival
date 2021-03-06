//
//  GameScene.swift
//  TechAgeSurvival
//
//  Created by Thera on 3/27/20.
//  Copyright © 2020 Skygazers. All rights reserved.
//

import SpriteKit
import GameplayKit
import HealthKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var updateInterval : TimeInterval = 100
    private var timeCount: TimeInterval = 0
    private var lastUpdateDate: Date = Date()
    
    private var eyelabel : SKLabelNode!
    private var waterlabel : SKLabelNode!
    private var fitnesslabel : SKLabelNode!
    private var healthlabel : SKLabelNode!
    private var happinesslabel : SKLabelNode!
    
    private var eyebar : SKSpriteNode!
    private var waterbar : SKSpriteNode!
    private var fitnessbar : SKSpriteNode!
    private var healthbar : SKSpriteNode!
    private var happinessbar : SKSpriteNode!
    
    private var waterbutton : FTButtonNode!
    private var eyebutton : FTButtonNode!
    private var fitnessbutton : FTButtonNode!

    private var eyevalue : CGFloat = 100
    private var watervalue : CGFloat = 60
    private var fitnessvalue : CGFloat = 0
    private var healthvalue : CGFloat = 80
    private var happinessvalue : CGFloat = 100
    private var stepvalue: CGFloat = 0
    private var fitnessbase: CGFloat = 0
        
    private let progressBarSize: CGFloat = 200
    private var fitnessGoal: CGFloat = 8000

    
    override func sceneDidLoad() {
//        self.eyevalue.run(SKAction.fadeIn(withDuration: 2.0))

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.eyelabel = self.childNode(withName: "//EyeValue") as? SKLabelNode
        self.waterlabel = self.childNode(withName: "//WaterValue") as? SKLabelNode
        self.fitnesslabel = self.childNode(withName: "//FitnessValue") as? SKLabelNode
        self.healthlabel = self.childNode(withName: "//HealthValue") as? SKLabelNode
        self.happinesslabel = self.childNode(withName: "//HappinessValue") as? SKLabelNode
        
        self.eyebar = self.childNode(withName: "//EyeBar") as? SKSpriteNode
        self.waterbar = self.childNode(withName: "//WaterBar") as? SKSpriteNode
        self.fitnessbar = self.childNode(withName: "//FitnessBar") as? SKSpriteNode
        self.healthbar = self.childNode(withName: "//HealthBar") as? SKSpriteNode
        self.happinessbar = self.childNode(withName: "//HappinessBar") as? SKSpriteNode
        
        self.eyebutton = self.childNode(withName: "//EyeButton") as? FTButtonNode
        self.waterbutton = self.childNode(withName: "//WaterButton") as? FTButtonNode
        self.fitnessbutton = self.childNode(withName: "//FitnessButton") as? FTButtonNode
        
//        let buttonTexture: SKTexture! = SKTexture(imageNamed: "button")
        let buttonTextureSelected = SKTexture(imageNamed: "upicon_inverse.png")
//        let button = FTButtonNode(normalTexture: buttonTexture, selectedTexture: buttonTextureSelected, disabledTexture: buttonTexture)
        eyebutton.selectedTexture = buttonTextureSelected
        waterbutton.selectedTexture = buttonTextureSelected
        fitnessbutton.selectedTexture = buttonTextureSelected
        eyebutton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.eyeupdate))
        waterbutton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.waterupdate))
        fitnessbutton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.fitnessupdate))
        
        updateTime()
        updateElements()
    }
    
    @objc func eyeupdate() {
        eyevalue = 100
        updateTime()
        updateElements()
    }
    
    @objc func waterupdate() {
        watervalue = 100
        updateTime()
        updateElements()
    }
    
    @objc func fitnessupdate() {
        fitnessbase += 10
        updateTime()
        updateElements()
    }
    
    func getSteps(completion: @escaping (Double) -> Void) {
        let healthStore = HKHealthStore()
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        healthStore.execute(query)
    }
    
    func updateTime() {
        let dateNow = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: dateNow) //11
        let minute = calendar.component(.minute, from: dateNow) //55
        let weekDay = calendar.component(.day, from: dateNow) //6 (Friday)
        
        if (weekDay != calendar.component(.day, from: lastUpdateDate)) {
            eyevalue = 100
            watervalue = 60
            happinessvalue = 100
        } else {
            let minuteSince = CGFloat((Int(dateNow - lastUpdateDate) / 60) % 60)
            eyevalue -= minuteSince / 20 * 40
            watervalue -= minuteSince / 60 * 10
        }
        getSteps(completion:
            { steps in self.stepvalue = CGFloat(steps) / self.fitnessGoal * 100 })
        fitnessvalue = fitnessbase + stepvalue
        healthvalue +=
            ((eyevalue - 60) / 100 + (watervalue - 60) / 100 + fitnessvalue / 100) / 20

        self.lastUpdateDate = dateNow
    }
    
    func updateElements() {
        watervalue = min(100, max(0, watervalue))
        eyevalue = min(100, max(0, eyevalue))
        fitnessvalue = min(100, max(0, fitnessvalue))
        happinessvalue = min(100, max(0, happinessvalue))
        healthvalue = min(100, max(0, healthvalue))
        
        self.eyelabel.text = String(Int(self.eyevalue))
        self.waterlabel.text = String(Int(self.watervalue))
        self.fitnesslabel.text = String(Int(self.fitnessvalue))
        self.healthlabel.text = String(Int(self.healthvalue))
        self.happinesslabel.text = String(Int(self.happinessvalue))
        
        self.eyebar.size.width = self.eyevalue / 100 * self.progressBarSize
        self.waterbar.size.width = self.watervalue / 100 * self.progressBarSize
        self.fitnessbar.size.width = self.fitnessvalue / 100 * self.progressBarSize
        self.healthbar.size.width = self.healthvalue / 100 * self.progressBarSize
        self.happinessbar.size.width = self.happinessvalue / 100 * self.progressBarSize
        
        self.eyebar.color = valueToColor(self.eyevalue)
        self.waterbar.color = valueToColor(self.watervalue)
        self.fitnessbar.color = valueToColor(self.fitnessvalue)
        self.healthbar.color = valueToColor(self.healthvalue)
        self.happinessbar.color = valueToColor(self.happinessvalue)
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
        self.timeCount += dt
        if (self.timeCount > updateInterval) {
            self.lastUpdateTime = currentTime
            self.timeCount = 0
            updateTime();
            updateElements();
        }

        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
    }
}


extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
