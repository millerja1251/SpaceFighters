//
//  GameViewController.swift
//  SpaceFighters
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  Apr 16 11:59

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {

	var scene: SKScene?
	var popSound: AVPlayer?
	var gameBackgroundSound: AVPlayer?
	
	@IBAction func goHome(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "homeView") as! HomeMenuViewController
        viewController.modalPresentationStyle = .fullScreen
        
		gameBackgroundSound?.pause()
		popSound?.play()
        self.present(viewController, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
			if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
				scene.scaleMode = .aspectFill
				
				scene.giveParentController(controller: self)
				
                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = false
            view.showsNodeCount = false
        }
		
		if let popSoundURL = Bundle.main.url(forResource: "pop", withExtension: "mp3") {
			popSound = AVPlayer(url: popSoundURL)
		}
		
		if let gameBackgroundSoundURL = Bundle.main.url(forResource: "game_background", withExtension: "mp3") {
			gameBackgroundSound = AVPlayer(url: gameBackgroundSoundURL)
		}
		
		gameBackgroundSound?.play()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
	
	override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		if motion == .motionShake {
			if let skView = view as? SKView, let scene = skView.scene as? GameScene {
				scene.shakeHandler()
			}
		}
	}
	
	func gameEnded() {
		scene?.removeFromParent()
		if let view = self.view as! SKView? {
			// Load the SKScene from 'GameScene.sks'
			if let scene = SKScene(fileNamed: "GameScene") {
				// Set the scale mode to scale to fit the window
				scene.scaleMode = .aspectFill

				// Present the scene
				view.presentScene(scene)
			}

			view.ignoresSiblingOrder = true

			view.showsFPS = false
			view.showsNodeCount = false
		}
	}
}
