//
//  HomeMenuViewController.swift
//  SpaceFighters
//
//  Created by Katie Stevenson on 4/16/22.
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  Apr 24 11:59

import UIKit

class HomeMenuViewController: UIViewController {

	//Segue to the game view with a button
	@IBAction func switchToGame(_ sender: Any) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "gameView") as! GameViewController
		viewController.modalPresentationStyle = .fullScreen
		
		self.present(viewController, animated: false, completion: nil)

	}
	
	//Segue to to the options view with a button
	@IBAction func switchToOptions(_ sender: Any) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "optionsView") as! OptionsViewController
		viewController.modalPresentationStyle = .fullScreen
		
		self.present(viewController, animated: false, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}
	
}
