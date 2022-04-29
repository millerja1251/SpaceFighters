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
    var audioPlayer : AVPlayer!
    
    @IBAction func goHome(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "homeView") as! HomeMenuViewController
        viewController.modalPresentationStyle = .fullScreen
        
        self.present(viewController, animated: false, completion: nil)
        popSound()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
			if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
				scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
            gameSound()
        }
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
    func popSound() {
        guard let url = Bundle.main.url(forResource: "pop", withExtension: "mp3") else {
            print("error to get the mp3 file")
            return
            
        }
        do {
            audioPlayer = try AVPlayer(url: url)
            audioPlayer?.play()
            
        } catch {
            print("audio file error")
            
        }
        
    }
    func gameSound() {
        guard let url = Bundle.main.url(forResource: "game_background", withExtension: "mp3") else {
            print("error to get the mp3 file")
            return
            
        }
        do {
            audioPlayer = try AVPlayer(url: url)
            audioPlayer?.play()
            
        } catch {
            print("audio file error")
            
        }
        
    }
}
