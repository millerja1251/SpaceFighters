//
//  HomeMenuViewController.swift
//  SpaceFighters
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  Apr 28 11:59

import UIKit
import AVFoundation

class HomeMenuViewController: UIViewController {
	var popSound: AVPlayer?
	var backgroundSound: AVPlayer?
	
	// Segue to the game view with a button
	@IBAction func switchToGame(_ sender: Any) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "gameView") as! GameViewController
		viewController.modalPresentationStyle = .fullScreen
		
		popSound?.play()
		backgroundSound?.pause()
		self.present(viewController, animated: false, completion: nil)

	}
	
	// Segue to to the options view with a button
	@IBAction func switchToOptions(_ sender: Any) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "optionsView") as! OptionsViewController
		viewController.modalPresentationStyle = .fullScreen
		
		popSound?.play()
		backgroundSound?.pause()
		self.present(viewController, animated: false, completion: nil)
	}
	
	@IBAction func switchToLeaderboards(_ sender: Any) {
		popSound?.play()
		backgroundSound?.pause()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let popSoundURL = Bundle.main.url(forResource: "pop", withExtension: "mp3") {
			popSound = AVPlayer(url: popSoundURL)
		}
		
		if let backgroundSoundURL = Bundle.main.url(forResource: "background_sound_menu", withExtension: "mp3") {
			backgroundSound = AVPlayer(url: backgroundSoundURL)
		}
		
		backgroundSound?.play()
		
	}
}
