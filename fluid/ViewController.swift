//
//  ViewController.swift
//  fluid
//
//  Created by Ziyad Khalil on 5/6/19.
//  Copyright © 2019 Ziyad Khalil. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    var container: NSPersistentContainer!
    var dateText: String!
//    var data = ["Fetch Anna from school","Get a burger","Buy Tickets for the movie","Fetch Anna from school","Get a burger","Buy Tickets for the movie","Fetch Anna from school","Get a burger","Buy Tickets for the movie","Fetch Anna from school","Get a burger","Buy Tickets for the movie","Fetch Anna from school","Get a burger","Buy Tickets for the movie"]
//    var data: [Entity] = []
    var tasksData: [Entity] = []
    var eventsData: [Entity] = []
    var notesData: [Entity] = []
    @IBOutlet weak var eventsTable: UITableView!
    //IB outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tasksTable: UITableView!
    @IBOutlet weak var notesTable: UITableView!
    
    //NavigationBar Reference
    var navBarController: NavBarController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTable.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navBarController.setNavigationBarHidden(true, animated: true)
        dateLabel.text? = dateText
        tasksData = navBarController.currentTasks
        eventsData = navBarController.currentEvents
        notesData = navBarController.currentNotes
        reloadTables()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navBarController.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let targetVC = segue.destination as! DetailsViewController;
        let segueIdentifier = segue.identifier!
        targetVC.navBarController = navBarController
        

        switch(segueIdentifier){
        case "EventsDetails":
            targetVC.title! = "Events"
            targetVC.data = eventsData
            targetVC.currentMode = .event
            navBarController.navigationBar.tintColor = UIColor(named: "trkwaz")
            navBarController.navigationBar.titleTextAttributes![NSAttributedString.Key.foregroundColor] = UIColor(named: "trkwaz")

            break
        case "NotesDetails":
            targetVC.title! = "Notes"
            targetVC.data = notesData
            targetVC.currentMode = .note
            navBarController.navigationBar.tintColor = UIColor.white
            navBarController.navigationBar.titleTextAttributes![NSAttributedString.Key.foregroundColor] = UIColor.white


            break
        case "TasksDetails":
            targetVC.title = "Tasks"
            targetVC.data = tasksData
            targetVC.currentMode = .task
            navBarController.navigationBar.tintColor = UIColor(named: "LamonyKamony")
            navBarController.navigationBar.titleTextAttributes![NSAttributedString.Key.foregroundColor] = UIColor(named: "LamonyKamony")
            

            break
        
        default:
            break
        }
        
    }
    
    func reloadTables(){
        tasksTable.reloadData()
        notesTable.reloadData()
        eventsTable.reloadData()
    }
    
    }

//--MARK: TABLE DELEGATE AND DATA SOURCE EXTENSION
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (tableView.tag) {
        case 0:
            return tasksData.count
        case 1:
            return notesData.count
        case 2:
            return eventsData.count
        default:
            return -1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        let label: UILabel!
        switch(tableView.tag){
        case 0:
            if !tasksData[indexPath.row].isTaskDone {
                cell = tableView.dequeueReusableCell(withIdentifier: "UnfinishedBusiness")
                label = (cell.subviews[0].subviews[0] as! UILabel)
                label.text = tasksData[indexPath.row].value!
            }
            else {
                cell = tableView.dequeueReusableCell(withIdentifier: "FinishedBusiness")
                label = (cell.subviews[0].subviews[0] as! UILabel)
                label.attributedText = tasksData[indexPath.row].value!.strikeThrough()
            }
            break
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "Note")
            label = (cell.subviews[0].subviews[0] as! UILabel)
            label.text = notesData[indexPath.row].value!
            break
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "Event")
            label = (cell.subviews[0].subviews[0] as! UILabel)
            label.text = eventsData[indexPath.row].value!
            break
        default:
            break
        }
        
        return cell
    }
    
    
}
