//
//  HomeMenuViewController.swift
//  SpaceFighters
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  Apr 24 11:59

import UIKit
import AVFoundation

class HomeMenuViewController: UIViewController {
    var audioPlayer : AVPlayer!

	//Segue to the game view with a button
	@IBAction func switchToGame(_ sender: Any) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "gameView") as! GameViewController
		viewController.modalPresentationStyle = .fullScreen
		
		self.present(viewController, animated: false, completion: nil)
        popSound()

	}
	
	//Segue to to the options view with a button
	@IBAction func switchToOptions(_ sender: Any) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "optionsView") as! OptionsViewController
		viewController.modalPresentationStyle = .fullScreen
		
		self.present(viewController, animated: false, completion: nil)
        popSound()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
        backgroundSound()

		// Do any additional setup after loading the view.
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
    func backgroundSound() {
        guard let url = Bundle.main.url(forResource: "background_sound_menu", withExtension: "mp3") else {
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
