//
//  CreateUserViewController.swift
//  SpaceFighters
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  May 5th, 5:00 PM

import UIKit
import CoreData
import AVFoundation

class CreateUserViewController: UIViewController {
	
	let context = AppDelegate.viewContext
	var popSound: AVPlayer?
	
	@IBAction func backToOptions(_ sender: Any) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "optionsView") as! OptionsViewController
		viewController.modalPresentationStyle = .fullScreen
		
		popSound?.play()
		self.present(viewController, animated: false, completion: nil)
	}
	
	@IBOutlet weak var textField: UITextView!
	
	// Creates a new instance of a GamePlayer and adds it to the context
	@IBAction func createUser(_ sender: Any) {
		
		let newUser: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "GamePlayer", into: context)
		newUser.setValue(textField.text, forKey: "name")
		print(newUser)
		
		do {
			try self.context.save()
			popSound?.play()
		}
		catch {
			
		}
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let popSoundURL = Bundle.main.url(forResource: "pop", withExtension: "mp3") {
			popSound = AVPlayer(url: popSoundURL)
		}
	}
}
