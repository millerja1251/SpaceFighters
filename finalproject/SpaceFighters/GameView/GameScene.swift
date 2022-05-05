//
//  GameScene.swift
//  SpaceFighters
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  May 5th, 5:00 PM

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	// sets up the player sprite, the score label, and the app context
	let player = SKSpriteNode(imageNamed: "player")
	var scoreLabel: SKLabelNode!
	let context = AppDelegate.viewContext
	
	// sets up a score variable that also sets the score label when updated
	var score: Int = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	
	// sets up the parent controller reference for self destruction
	var parentController: GameViewController?
	
	var gameTimer: Timer!
	
	// bitfields for collision detection, handled by SpriteKit and GameplayKit
	let bottomCategory: UInt32 = 0x1 << 2
	let enemyCategory: UInt32 = 0x1 << 1
	let bulletCategory: UInt32 = 0x1 << 0
	
	
	// function to grab parent controller (used by GameViewController to give reference to itself)
	func giveParentController(controller: GameViewController) {
		parentController = controller
	}
	
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
	
	// detect player sliding their finger and update the player x-coordinate accordingly
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let location = touch.location(in: self)
			player.position.x = location.x
		}
	}
	
	// adds an enemy to the screen, and places it somewhere on the frame (and not right on the edges)
	// also adds physics and collision to spawned enemy
	// sets up an animation for them to move down (can be disrupted by collision)
	@objc func addEnemy() {
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
	
	// on shake gesture, shoot
	func shakeHandler() {
		shoot()
	}
	
	// to shoot, play the sound (and don't wait for it to complete to continue code execution
	// set up the sprite, the physics and collision, as well as its upward animation
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
	
	// detect physics collisions on two physics bodies and check for the type of collision (and what to do about it)
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
		
		// on enemy hitting bottom of screen, end current game session, and if applicable update and save scores
		if (firstBody.categoryBitMask == enemyCategory && secondBody.categoryBitMask == bottomCategory) {
			let appDelegate = UIApplication.shared.delegate as! AppDelegate
			if let currentPlayer = appDelegate.currentGamePlayer {
				if (currentPlayer.hardMode && currentPlayer.hardModeHighScore < score) {
					currentPlayer.hardModeHighScore = Int64(score)
					do {
						try self.context.save()
					} catch {
						
					}
				} else if (!currentPlayer.hardMode && currentPlayer.easyModeHighScore < score) {
					currentPlayer.easyModeHighScore = Int64(score)
					do {
						try self.context.save()
					} catch {
						
					}
				}
			}
			restart()
		}
	}
	
	// restart scene by passing off to parent and killing this scene and creating a new one
	func restart() {
		if let parentController = parentController {
			parentController.gameEnded()
		}
	}
	
	// increment score on collision with enemy, play a sound, and remove both nodes
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
