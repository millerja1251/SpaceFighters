//
//  CreateUserViewController.swift
//  SpaceFighters
//
//  Created by Katie Stevenson on 4/16/22.
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu
//  SpaceFighters
//  Apr 16 11:59

import UIKit
import CoreData

class CreateUserViewController: UIViewController {
    
    let coreDataContainer = AppDelegate.persistentContainer
    let context = AppDelegate.viewContext
    
    @IBOutlet weak var textField: UITextView!
    @IBAction func createUser(_ sender: Any) {
        let newUser: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "GamePlayer", into: context)
        
        newUser.setValue(textField.text, forKey: "name")
        
        print("\(newUser)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let newUser: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "GamePlayer", into: context)
        
        print("\(newUser)")
    }

}
