//
//  GameScene.swift
//  SpaceFighters
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  Apr 25 11:59

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	let player = SKSpriteNode(imageNamed: "player")
	var scoreLabel: SKLabelNode!
	var score: Int = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	
	var gameTimer: Timer!
	var enemyTypes = ["fast", "normal", "slow"]
	
	let bottomCategory: UInt32 = 0x1 << 2
	let enemyCategory: UInt32 = 0x1 << 1
	let bulletCategory: UInt32 = 0x1 << 0
	
	
	override func didMove(to view: SKView) {
		if let stars = SKEmitterNode(fileNamed: "Stars") {
			stars.position = CGPoint(x: frame.midX, y: frame.maxY)
			stars.zPosition = -1
			stars.advanceSimulationTime(10)
			addChild(stars)
		}
		
		
		player.name = "player"
		player.position = CGPoint(x: frame.midX, y: frame.midY - 200)
		player.zPosition = 1
		addChild(player)
		
		self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
		self.physicsWorld.contactDelegate = self
		
		scoreLabel = SKLabelNode(text: "Score: 0 ")
		scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
		scoreLabel.fontColor = UIColor.white
		scoreLabel.zPosition = 99
		score = 0
		
		self.addChild(scoreLabel)
		
		let appDelegate = AppDelegate()
		if let currentPlayer = appDelegate.currentGamePlayer {
			if currentPlayer.hardMode {
				gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
			} else {
				gameTimer = Timer.scheduledTimer(timeInterval: 1.25, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
			}
		} else {
			gameTimer = Timer.scheduledTimer(timeInterval: 1.25, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
		}
		
		let bottomRect = CGRect(x: frame.minX, y: frame.minY, width: frame.size.width, height: 1)
		let bottom = SKNode()
		bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomRect)
		addChild(bottom)
		
		bottom.physicsBody?.categoryBitMask = bottomCategory
		
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let location = touch.location(in: self)
			player.position.x = location.x
		}
	}
	
	@objc func addEnemy() {
		enemyTypes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: enemyTypes) as! [String]
		
		let enemy = SKSpriteNode(imageNamed: "enemy")
		
		let randomEnemyPosition = GKRandomDistribution(lowestValue: Int(frame.midX - 100), highestValue: Int(frame.midX + 100))
		
		let position = CGFloat(randomEnemyPosition.nextInt())
		
		enemy.position = CGPoint(x: position, y: self.frame.maxY + enemy.size.height)
		
		enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
		enemy.physicsBody?.isDynamic = true
		
		enemy.physicsBody?.categoryBitMask = enemyCategory
		enemy.physicsBody?.contactTestBitMask = bulletCategory
		enemy.physicsBody?.collisionBitMask = 0
		
		enemy.physicsBody?.contactTestBitMask = bottomCategory
		
		enemy.setScale(0.75)
		enemy.zPosition = 2
		
		self.addChild(enemy)
		
		let animationDuration: TimeInterval = 6
		
		var actionArray = [SKAction]()
		
		actionArray.append(SKAction.move(to: CGPoint(x: position, y: self.frame.minY), duration: animationDuration))
		actionArray.append(SKAction.removeFromParent())
		
		enemy.run(SKAction.sequence(actionArray))
		
	}
	
	func shakeHandler() {
		shoot()
	}
	
	func shoot() {
		self.run(SKAction.playSoundFileNamed("laser_shot.mp3", waitForCompletion: false))
		
		let bulletNode = SKSpriteNode(imageNamed: "bullet_b")
		bulletNode.setScale(0.20)
		
		bulletNode.position = player.position
		bulletNode.position.y += 5
		bulletNode.physicsBody = SKPhysicsBody(circleOfRadius: bulletNode.size.width / 2)
		bulletNode.physicsBody?.isDynamic = true
		
		bulletNode.physicsBody?.categoryBitMask = bulletCategory
		bulletNode.physicsBody?.contactTestBitMask = enemyCategory
		bulletNode.physicsBody?.collisionBitMask = 0
		
		bulletNode.physicsBody?.usesPreciseCollisionDetection = true
		
		self.addChild(bulletNode)
		
		let animationDuration: TimeInterval = 0.3
		
		var actionArray = [SKAction]()
		
		actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: self.frame.size.height + 10), duration: animationDuration))
		actionArray.append(SKAction.removeFromParent())
		
		bulletNode.run(SKAction.sequence(actionArray))
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
		var firstBody: SKPhysicsBody
		var secondBody: SKPhysicsBody
		
		if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
			firstBody = contact.bodyA
			secondBody = contact.bodyB
		} else {
			firstBody = contact.bodyB
			secondBody = contact.bodyA
		}
		
		if (firstBody.categoryBitMask & bulletCategory) != 0 && (secondBody.categoryBitMask & enemyCategory) != 0 {
			if let nodeOne = firstBody.node as? SKSpriteNode {
				if let nodeTwo = secondBody.node as? SKSpriteNode {
					bulletCollisionWithEnemy(bulletNode: nodeOne, enemyNode: nodeTwo)
				}
			}
		}
		
		if (firstBody.categoryBitMask == enemyCategory && secondBody.categoryBitMask == bottomCategory) {
			let appDelegate = UIApplication.shared.delegate as! AppDelegate
			if let currentPlayer = appDelegate.currentGamePlayer {
				if (currentPlayer.hardMode && currentPlayer.hardModeHighScore < score) {
					currentPlayer.hardModeHighScore = Int64(score)
				} else if (!currentPlayer.hardMode && currentPlayer.easyModeHighScore < score) {
					currentPlayer.easyModeHighScore = Int64(score)
				}
			}
			restart()
		}
	}
	
	func restart() {
		let gameScene = GameScene(size: self.frame.size)
		gameScene.scaleMode = .aspectFill
		
		self.view!.presentScene(gameScene)
	}
	
	func bulletCollisionWithEnemy(bulletNode: SKSpriteNode, enemyNode: SKSpriteNode) {
		let explosion = SKEmitterNode(fileNamed: "Explosion")!
		explosion.position = enemyNode.position
		self.addChild(explosion)
		
		self.run(SKAction.playSoundFileNamed("enemy_down.mp3", waitForCompletion: false))
		
		bulletNode.removeFromParent()
		enemyNode.removeFromParent()
		
		self.run(SKAction.wait(forDuration: 2)) {
			explosion.removeFromParent()
		}
		
		score += 1
	}
}
