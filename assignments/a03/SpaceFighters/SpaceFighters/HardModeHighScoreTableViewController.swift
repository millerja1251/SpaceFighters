//
//  HardModeHighScoreTableViewController.swift
//  SpaceFighters
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  Apr 25 11:59

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

		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false

		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
		self.getUsers()
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
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
	

	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}
	*/

	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// Delete the row from the data source
			tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	*/

	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

	}
	*/

	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the item to be re-orderable.
		return true
	}
	*/

	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
	}
	*/

}
