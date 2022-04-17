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
//  Apr 16 11:59

import UIKit

class HomeMenuViewController: UIViewController {

    @IBAction func switchToGame(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "gameView") as! GameViewController
        viewController.modalPresentationStyle = .fullScreen
        
        self.present(viewController, animated: false, completion: nil)

    }
    
    @IBAction func switchToOptions(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "optionsView") as! OptionsViewController
        viewController.modalPresentationStyle = .fullScreen
        
        self.present(viewController, animated: false, completion: nil)
    }
    
    /*
    @IBAction func switchToLeaderboard(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "leaderBoardTab") as! TabBarViewController
        viewController.modalPresentationStyle = .fullScreen
        
        self.present(viewController, animated: false, completion: nil)
    }
    */
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
