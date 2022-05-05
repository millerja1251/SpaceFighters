//
//  HardModeHighScoreTableViewController.swift
//  SpaceFighters
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  May 5th, 5:00 PM

import UIKit
import CoreData

class HardModeHighScoreTableViewController: UITableViewController {
	
	let context = AppDelegate.viewContext
	var users: [GamePlayer] = []
	
	// Gets the data from the context and puts it into the user list in order by high score
	func getUsers() {
		do {
			let request = GamePlayer.fetchRequest() as NSFetchRequest<GamePlayer>
			let sort = NSSortDescriptor(key: "hardModeHighScore", ascending: false)
			request.sortDescriptors = [sort]
			self.users = try context.fetch(request)
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
		catch {
			
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		if let myTableView = self.tableView {
			myTableView.reloadData()
			self.tableView.rowHeight = 150
			
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.getUsers()
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}

	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "hardHighScoreCellView", for: indexPath) as! HardHighScoreTableViewCell

		// Configure the cell...
		let user = users[indexPath.row]
		
		cell.playerName.text = user.name
		cell.playerScore.text = "\(user.hardModeHighScore)"

		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "HighScores"
	}
}
