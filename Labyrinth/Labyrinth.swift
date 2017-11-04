//
//  Labyrinth.swift
//  SampleGame
//
//  Created by Josh Getter on 11/4/17.
//  Copyright © 2017 Josh Getter. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class Labyrinth: SKScene{
    private var ball : SKSpriteNode?;
    private var stone : SKTileMapNode?;
    var motionManager : CMMotionManager?;
    override func didMove(to view: SKView) {
        //Setup edges
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame);
        //Setup Ball
        ball = self.childNode(withName: "ball") as? SKSpriteNode;
        ball?.physicsBody = SKPhysicsBody.init(texture: SKTexture.init(imageNamed: "Spaceship"), size: (ball?.size)!);
        ball?.physicsBody?.isDynamic = true;
        ball?.physicsBody?.affectedByGravity = false;
        ball?.physicsBody?.mass = 0.02;
        //Stone Setup
        stone = self.childNode(withName: "stone") as? SKTileMapNode;
        //SETUP MOTION HANDLING
        motionManager = CMMotionManager();
        motionManager?.startAccelerometerUpdates();
    }
    func processDeviceMotion(forUpdate currentTime: CFTimeInterval){
        //TODO Handle device flip causing control inversion
        //TODO Add friction to either ground or ball
        if(self.motionManager != nil){
            if let data = self.motionManager?.accelerometerData{
                if (fabs(data.acceleration.x) > 0.2){
                    ball?.physicsBody!.applyForce(CGVector(dx: 0, dy: 40*CGFloat(data.acceleration.x)));
                }
                if(fabs(data.acceleration.y) > 0.2){
                    ball?.physicsBody!.applyForce(CGVector(dx: -40 * CGFloat(data.acceleration.y), dy: 0));
                }
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is renderedˆ
        processDeviceMotion(forUpdate: currentTime);
    }
    
    
}
