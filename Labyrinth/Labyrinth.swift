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
    let BALLRADIUS = CGFloat(20);
    private var ball : SKShapeNode?;
    private var stone : SKTileMapNode?;
    var motionManager : CMMotionManager?;
    override func didMove(to view: SKView) {
        //Setup edges
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame);
        //Setup Ball
        let ballPos = self.childNode(withName: "ball")?.position;
        ball = SKShapeNode(circleOfRadius: BALLRADIUS);
        if(ball != nil){
            ball!.fillColor = .black;
            ball!.strokeColor = .darkGray;
            ball!.physicsBody = SKPhysicsBody(circleOfRadius: BALLRADIUS);
            ball!.physicsBody?.isDynamic = true;
            ball!.physicsBody?.affectedByGravity = false;
            ball!.physicsBody?.mass = 0.02;
            ball!.position = ballPos!;
            self.childNode(withName: "ball")?.removeFromParent();
            self.addChild(ball!);
        }
        //Stone Setup
        stone = self.childNode(withName: "stone") as? SKTileMapNode;
        if(stone != nil){
            let tileSize = stone!.tileSize;
            let halfWidth = CGFloat(stone!.numberOfColumns)/2.0 * tileSize.width;
            let halfHeight = CGFloat(stone!.numberOfRows)/2.0 * tileSize.height;
            for row in 0..<stone!.numberOfRows{
                for col in 0..<stone!.numberOfColumns{
                    if let tile = stone!.tileDefinition(atColumn: col, row: row){
                        let tileTexture = tile.textures[0];
                        let physicsNode = SKNode();
                        let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width/2);
                        let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height/2);
                        physicsNode.position = CGPoint(x: x, y: y);
                        physicsNode.physicsBody = SKPhysicsBody(texture: tileTexture, size: stone!.tileSize);
                        physicsNode.physicsBody?.affectedByGravity = false;
                        physicsNode.physicsBody?.isDynamic = false;
                        stone!.addChild(physicsNode);
                    }
                }
            }
        }

        //SETUP MOTION HANDLING
        motionManager = CMMotionManager();
        motionManager?.startAccelerometerUpdates();
    }
    func processDeviceMotion(forUpdate currentTime: CFTimeInterval){
        //TODO Handle device flip causing control inversion.
        //TODO Add friction to either ground or ball.
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
