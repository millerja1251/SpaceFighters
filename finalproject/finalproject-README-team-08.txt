C323/ Spring 2022
Final Project
May 5th, 5:00 PM
Jackson Miller jm122
Hyungsuk Kang kang18
Elliot Helwig ehelwig
Team 08
SpaceFighters

I. Instructions

When the app is first opened the home menu page will appear. There are three buttons 
to choose from and each one will take you to a different view. The first is the play 
button which takes you to the Game Scene View. Inside the Game Scene the game will 
start playing as soon as the view appears. To controller the character you drag it 
horizontally across the bottom of the screen. Then to fire you shake the phone and 
after the shake is done the ship will fire. To do this on the simulator u can use the 
shortcut ctrl + cmd + z. The game is then over when the enemy ship hits the bottom of 
the screen not when it hits the players ship because that is not the loss condition. 
Then to go back home there is a <-Home button at the top of the Game Scene view. Once 
back home you can go to the leaderboard which is the second button on the view. The 
leaderboard will show up but not take up the whole screen and it is imbedded in a tab 
bar view controller so that you can switch between the hard mode and easy mode high-
score tables. Then to exit the leaderboard view you just swipe it down. The last 
button on the Home Screen which is the options button will take you to the options 
page of the app. There you are able to view the current signed in player, the list of 
all the players, the hard mode toggle and the ability to create a new user. To create 
a new user you click the create user button which will then make a new view appear 
where you enter your name. In that view you can input your name in the text field and 
click create user button right below it or if you decide you don't want to create a 
user and want to go back to the options page you can click the <-Options button. Now 
to select a user in the table all you have to do is click the user in the list and the 
current user label at the top of the view will update. If you decide to you want to 
delete a user you can slide the entry in the table to the left and it will delete the 
user. Finally the hard mode toggle at the bottom will decide the level of difficulty 
for the current user that is signed in. If it is green the hard mode is on and if it 
grey it is off. Finally to go back to the Home Screen there is also a <-Home button 
like the game scene view.


II. Running the app

We used Xcode version 13.2.1 and iOS version 15.1 and we tested the app on the iPhone 
12 Pro.

III. Features, Functionalities

1. We use MVC with the CoreData as the model, the multiple view controllers
connect access the CoreData through the AppDelegate and then transfer it to the 
different views.

2. Input: We take input through many different buttons in the files, 
HomeMenuViewController.swift, OptionsViewController.swift, CreateUser.swift. The 
player is able to control the spaceship with input as well and that is in the 
GameScene.swift file.

Output: We show output in our tables that fetch from the UserModel.xcdatamodel file 
and then populate the tables in the OptionsViewController.swift, EasyModeHighScoreViewController.swift,
HardModeHighscoreViewController.swift files.

Views: We have 7 different view controllers in the Main.storyboard which also contains 
a tab bar view controller to hold the the EasyModeHighScoreViewController and 
HardModeHighscoreViewController also in the Main.storyboard.

Table View Controller: We have 3 table view controllers in the Main.storyboard, the 
Options view controller, EasyModeHighScoreViewController and 
HardModeHighscoreViewController.

3. We did not make a calculator because our apps main functionality is being a game.

4. We implemented bot persistent settings and persistent storage. The persistent 
settings is implemented by having a persistently signed in user and that users 
settings i.e., the hard mode setting are persistently stored. And all the users and 
their data is persistently stored using CoreData and if the app is closed it is 
preserved. This is done using the UserModel.xcdatamodel file and it is accessed in the 
AppDelegate.swift, OptionsViewController.swift, CreateNewUserViewController.swift, 
EasyModeHighScoreViewController.swift, HardModeHighscoreViewController.swift files.

5. The first that we used is AVFoundation which is implemented in the 
OptionsViewController.swift, CreateUserViewController.swift, GameViewController.swift 
and the HomeMenuViewController.swift

The second that we used was CoreData which is implemented in the UserModel.xcdatamodel, 
AppDelegate.swift, OptionsViewController.swift, CreateNewUserViewController.swift, 
EasyModeHighScoreViewController.swift, and HardModeHighscoreViewController.swift 
files.

6. For the iOS framework that was not featured in class that we used was SpriteKit 
which was used in the GameScene.swift and GameViewController files.

IV. Changes

We majorly changed our project from assignment one because our original idea 
was considered too much like a calculator so in a sense we have completely redone 
everything since the first assignment. So we decided to create a game.

V. Contributions

Elliot: The 1/3 of the app that was Elliot's responsibility was the actual game functionality. This included creating player and enemy objects, projectiles, as well as score and a loss condition (to make it a game). This was done using SpriteKit and GameplayKit.

Jackson: The 1/3 of the app that Jackson worked on was everything that dealt with CoreData.
That included fetching data and also creating objects of entities to be added to the viewContext
He also did a lot of the options view controller code that had to deal with the table and all of the
Functionality in that Options view controller file. He also set up the leaderboards CoreData functionality

Kang: The 1/3 of the app that was Kang's responsibility was the sound effect functionality and the design components included in the app. This included image files of objects in the game, 5 types of sounds (background music & action feedback sound), and app icon designs. The AVFoundation was used to engage the process.

