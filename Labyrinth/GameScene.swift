//
//  GameScene.swift
//  SampleGame
//
//  Created by Josh Getter on 2/20/17.
//  Copyright © 2017 Josh Getter. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var spinnyNode : SKShapeNode?
    private var spaceship : SKSpriteNode?
    private var ground : SKTileMapNode?
    override func didMove(to view: SKView) {
        //Now in view
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame);
        guard let ground = self.childNode(withName: "ground") as? SKTileMapNode else{
            return;
        }
        spaceship = SKSpriteNode(imageNamed: "Spaceship")
        spaceship?.physicsBody = SKPhysicsBody(texture: (spaceship?.texture)!,size: (spaceship?.size)!);
        spaceship?.physicsBody?.affectedByGravity = true;
        spaceship?.physicsBody?.collisionBitMask = 1;
        
        let tileSize = ground.tileSize;
        let halfWidth = CGFloat(ground.numberOfColumns)/2.0 * tileSize.width;
        let halfHeight = CGFloat(ground.numberOfRows)/2.0 * tileSize.height;
        for row in 0..<ground.numberOfRows{
            for col in 0..<ground.numberOfColumns{
                let physicsNode = SKNode();
                let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width/2);
                let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height/2);
                physicsNode.position = CGPoint(x: x, y: y);
                physicsNode.physicsBody = SKPhysicsBody(texture: SKTexture.init(imageNamed: "Grass_Grid_Up"), size: ground.tileSize);
                physicsNode.physicsBody?.affectedByGravity = false;
                physicsNode.physicsBody?.isDynamic = false;
                ground.addChild(physicsNode);
            }
        }
            
            self.addChild(spaceship!);
    }
    func touchDown(atPoint pos : CGPoint) {
        if let z = self.spaceship {
            z.position = pos
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let z = self.spaceship{
            z.position = pos
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let z = self.spaceship{
            z.position = pos
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
