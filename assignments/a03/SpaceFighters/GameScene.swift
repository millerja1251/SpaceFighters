//
//  GameScene.swift
//  SpaceFighters
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  Apr 16 11:59

import SpriteKit

enum CollisionType: UInt32 {
	case player = 1
	case playerWeapon = 2
	case enemy = 4
	case enemyWeapon = 8
}

class GameScene: SKScene {
	let player = SKSpriteNode(imageNamed: "player")
	
	var isPlayerAlive = true
	let positions = Array(stride(from: -320, through: 320, by: 80))
	
	
	override func didMove(to view: SKView) {
		if let stars = SKEmitterNode(fileNamed: "Stars") {
			stars.position = CGPoint(x: frame.midX, y: frame.maxY)
			stars.zPosition = -1
			addChild(stars)
		}
		
		
		player.name = "player"
		player.position = CGPoint(x: frame.midX, y: frame.midY - 200)
		player.zPosition = 1
		addChild(player)
	}
}
