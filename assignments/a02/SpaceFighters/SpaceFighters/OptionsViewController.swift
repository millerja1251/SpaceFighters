//
//  OptionsViewController.swift
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

class OptionsViewController: UIViewController {
    
    let coreDataContainer = AppDelegate.persistentContainer
    let context = AppDelegate.viewContext
    
    
    @IBAction func returnHome(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "homeView") as! HomeMenuViewController
        viewController.modalPresentationStyle = .fullScreen
        
        self.present(viewController, animated: false, completion: nil)
    }
    
    @IBAction func changeDifficulty(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
