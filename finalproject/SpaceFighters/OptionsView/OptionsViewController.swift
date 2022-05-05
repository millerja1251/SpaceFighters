//
//  OptionsViewController.swift
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

class OptionsViewController: UIViewController {
	
	var appDelegate: AppDelegate?
	var popSound: AVPlayer?
	
	@IBOutlet weak var currentUser: UILabel!
	@IBOutlet weak var tableView: UITableView!
	let context = AppDelegate.viewContext
	var users: [GamePlayer] = []
	@IBOutlet weak var gameModeSwitch: UISwitch!
	
	// Segue back to the home view with a button
	@IBAction func returnHome(_ sender: Any) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "homeView") as! HomeMenuViewController
		viewController.modalPresentationStyle = .fullScreen
		
		popSound?.play()
		self.present(viewController, animated: false, completion: nil)
	}
	
	// Changes the current players difficulty based on if the switch is on or off
	@IBAction func difficultyChanged(_ sender: UISwitch) {
		popSound?.play()
		if let currentGamePlayer = self.appDelegate?.currentGamePlayer {
			if (sender.isOn == true){
				currentGamePlayer.hardMode = true
			}
			else {
				currentGamePlayer.hardMode = false
			}
		}
		do {
			try self.context.save()
		} catch {
			
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.appDelegate = UIApplication.shared.delegate as? AppDelegate
		
		tableView.dataSource = self
		tableView.delegate = self
		
		self.getUsers()
		
		if let currentPlayer = self.appDelegate?.currentGamePlayer?.name {
			self.currentUser.text = currentPlayer
		} else {
			self.currentUser.text = "Guest"
		}
		
		if let constantGameMode = self.appDelegate?.currentGamePlayer?.hardMode {
			if (constantGameMode == true) {
				gameModeSwitch.isOn = true
			} else {
				gameModeSwitch.isOn = false
			}
		}
		
		if let popSoundURL = Bundle.main.url(forResource: "pop", withExtension: "mp3") {
			popSound = AVPlayer(url: popSoundURL)
		}
		
	}
	
	// Fetched the data from the context and puts it into a list called users
	func getUsers() {
		do {
			self.users = try context.fetch(GamePlayer.fetchRequest())
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
		catch {
			
		}
	}
}

extension OptionsViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return users.count
	}

	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "userCells", for: indexPath)
		
		let user = self.users[indexPath.row]
		
		cell.textLabel?.text = user.name
		// Configure the cell...
		return cell
	}
	
	// Allows for the deletion of a instance of a GamePlayer in the context with a slideing
	// delete button on the table view
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
			
			let removedUser = self.users[indexPath.row]
			self.context.delete(removedUser)
			do {
				try self.context.save()
			} catch {
				
			}
			self.getUsers()
		}
		return UISwipeActionsConfiguration(actions: [action])
	}
	
	// Changes the current player based off of the row selected in the table
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.appDelegate?.currentGamePlayer = self.users[indexPath.row]
		
		if let currentPlayer = self.appDelegate?.currentGamePlayer?.name {
			self.currentUser.text = currentPlayer
		}
		
		if let constantGameMode = self.appDelegate?.currentGamePlayer?.hardMode {
			if (constantGameMode == true) {
				gameModeSwitch.isOn = true
			} else {
				gameModeSwitch.isOn = false
			}
		}
		
		do {
			try self.context.save()
		}
		catch {
			
		}
	}
}
