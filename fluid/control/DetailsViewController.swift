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
    //IBOutlets
    @IBOutlet weak var table: UITableView!
    
    
    //MARK:- Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.data = navBarController.getData(mode: currentMode)
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        let label: UILabel!
        switch(currentMode!){
        case .task:
            if !data[indexPath.row].isTaskDone {
                cell = tableView.dequeueReusableCell(withIdentifier: "UnfinishedBusiness")
                label = (cell.subviews[0].subviews[0].subviews[0] as! UILabel)
            }
            else {
                cell = tableView.dequeueReusableCell(withIdentifier: "FinishedBusiness")
                label = (cell.subviews[0].subviews[0].subviews[0] as! UILabel)
            }
            label.text = data[indexPath.row].value
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

    
}
