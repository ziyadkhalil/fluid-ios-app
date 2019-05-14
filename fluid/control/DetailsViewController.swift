//
//  DetailsViewController.swift
//  fluid
//
//  Created by Ziyad Khalil on 5/7/19.
//  Copyright © 2019 Ziyad Khalil. All rights reserved.
//

import UIKit
class DetailsViewController: UIViewController {
    
    //MARK:- Attributes
    var navBarController: NavBarController!  //NavigationBar Reference
    var currentMode: EntityType!
    var data: [Entity] = []
    var unfinishedTasks: [Entity] = []
    var finishedTasks: [Entity] = []

    //IBOutlets
    @IBOutlet weak var table: UITableView!

    
    
    //MARK:- Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.data = navBarController.getData(mode: currentMode)
        finishedTasks = []
        unfinishedTasks = []
        data.forEach {task in
            if task.isTaskDone {
                finishedTasks.append(task)
            }
            else {
                unfinishedTasks.append(task)
            }
        }
        table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier!){
        case "AddingNewStuffSegue":
            let targetVC = (segue.destination as! NewEntityViewController)
            targetVC.navBarController = navBarController
            targetVC.currentMode = currentMode
            break
        default:
            break
        }
    }

    @IBAction func unwindAddingNewStuff(segue:UIStoryboardSegue) {}
    
  
    

}
//MARK:- TableView Extension
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.currentMode! {
        case .task:
            if section == 0 {
                return unfinishedTasks.count
            }
            else {return finishedTasks.count}
        default:
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        let label: UILabel!
        switch(currentMode!){
        case .task:
            if indexPath.section == 0 {
                let  cell = (tableView.dequeueReusableCell(withIdentifier: "UnfinishedBusiness") as! DetailsCell)
                label = cell.label
                label.text = unfinishedTasks[indexPath.row].value
                let gestRec = UIPanGestureRecognizer(target: cell, action: #selector(cell.swipe(_:)))
                let doneTap = UITapGestureRecognizer(target: cell, action: #selector(cell.doneTapped(_:)))
                let removeTap = UITapGestureRecognizer(target: cell, action: #selector(cell.removeTapped(_:)))

                gestRec.maximumNumberOfTouches = 1 
                cell.mainView.addGestureRecognizer(gestRec)
                cell.doneView.addGestureRecognizer(doneTap)
                cell.removeView.addGestureRecognizer(removeTap)
                cell.doneSwipingAction = { [unowned self] in
                    let movedTask = self.unfinishedTasks[indexPath.row]
                    movedTask.isTaskDone = true
                    self.unfinishedTasks.remove(at: indexPath.row)
                    self.finishedTasks.append(movedTask)
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [indexPath], with: .left)
                    tableView.insertRows(at: [IndexPath(row: self.finishedTasks.count-1, section: 1)], with: .left)
                    tableView.endUpdates()
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
                        tableView.reloadData()
                    })
                    self.navBarController.saveData()
                }
                cell.removeSwipingAction = { [unowned self] in
                    let entity = self.unfinishedTasks[indexPath.row]
                    self.navBarController.removeEntity(entity)
                    self.unfinishedTasks.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
                        tableView.reloadData()
                    })
                }
                
//                cell.doneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector()))
                return cell
            }
            else {
                cell = tableView.dequeueReusableCell(withIdentifier: "FinishedBusiness")
                cell.action
                label = (cell.subviews[0].subviews[0].subviews[0] as! UILabel)
            }
            label.text = finishedTasks[indexPath.row].value
            break
        case .note:
            cell = tableView.dequeueReusableCell(withIdentifier: "Note")
            label = (cell.subviews[0].subviews[0].subviews[0] as! UILabel)
            label.text = data[indexPath.row].value
            break
        case .event:
            cell = tableView.dequeueReusableCell(withIdentifier: "Event")
            label = (cell.subviews[0].subviews[0].subviews[0] as! UILabel)
            label.text = data[indexPath.row].value
            break
        }
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.currentMode! {
        case .task:
            return 2
        default:
            return 1
        }
    }
}
