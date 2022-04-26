//
//  CreateUserViewController.swift
//  SpaceFighters
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  Apr 24 11:59

import UIKit
import CoreData

class CreateUserViewController: UIViewController {
	
	let context = AppDelegate.viewContext
	
	@IBAction func backToOptions(_ sender: Any) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "optionsView") as! OptionsViewController
		viewController.modalPresentationStyle = .fullScreen
		
		self.present(viewController, animated: false, completion: nil)
	}
	@IBOutlet weak var textField: UITextView!
	
	//Creates a new instance of a GamePlayer and adds it to the context
	@IBAction func createUser(_ sender: Any) {
		
		let newUser: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "GamePlayer", into: context)
		newUser.setValue(textField.text, forKey: "name")
		print(newUser)
		
		do {
			try self.context.save()
		}
		catch {
			
		}
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
}
