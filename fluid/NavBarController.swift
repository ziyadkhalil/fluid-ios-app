//
//  NavBarController.swift
//  fluid
//
//  Created by Ziyad Khalil on 5/7/19.
//  Copyright © 2019 Ziyad Khalil. All rights reserved.
//

import UIKit
import CoreData
class NavBarController: UINavigationController {
  
    // -MARK: Attributes
    var container: NSPersistentContainer!
    var currentDate: Date!
    var startDate: Date!
    var endDate: Date!
    var currentTasks: [Entity] = []
    var currentNotes: [Entity] = []
    var currentEvents: [Entity] = []
    var mainController: ViewController!
    
    // -MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentDate()
        print("CURRENT DATE:", currentDate)
        (self.viewControllers[0] as! ViewController).navBarController = self
        initCoreData()
        setMainController()

    }
    func getCurrentDate(){
        currentDate = Date()
        endDate = currentDate.endOfDay
        startDate = currentDate.startOfDay
    }
    
    func initCoreData(){
        container = NSPersistentContainer(name: "fluid")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        loadData()
    }

    func loadData(){
        let request = Entity.createFetchRequest()
        request.predicate = NSPredicate(
            format: "(type == 'task') AND (date >= %@) AND (date <= %@)", argumentArray: [startDate , endDate])
        do {
            self.currentTasks = try container.viewContext.fetch(request)
        } catch {
            print("Fetch failed")
        }
//        request = Entity.createFetchRequest()
        request.predicate = NSPredicate(
        format: "(type == 'event') AND (date >= %@) AND (date <= %@)", argumentArray: [startDate , endDate])
        do {
            self.currentEvents = try container.viewContext.fetch(request)
        } catch {
            print("Fetch failed")
        }
//        request = Entity.createFetchRequest()
        request.predicate = NSPredicate(
        format: "(type == 'note') AND (date >= %@) AND (date <= %@)", argumentArray: [startDate , endDate])
        do {
            self.currentNotes = try container.viewContext.fetch(request)
        } catch {
            print("Fetch failed")
        }
    }
    
    func setMainController(){
        mainController = (self.viewControllers[0] as! ViewController)
        refresh()
    }
    
    func saveDate(){
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    func addEntity(mode: EntityType, value: String){
        let entity = Entity(context: container.viewContext)
        entity.value = value
        entity.type = mode.toString()
        entity.date = currentDate
        switch(mode){
        case .task:
            currentTasks.append(entity)
            entity.isTaskDone = false
            break
        case .note:
            currentNotes.append(entity)
            break
        case .event:
            currentEvents.append(entity)
            break
        }
        saveDate()
        print("added")
        
    }
    
    func getData(mode: EntityType) -> [Entity] {
        switch(mode){
        case .task:
            return currentTasks
        case .note:
            return currentNotes
        case .event:
            return currentEvents
        }
    }
    
    func setNewDate(date: Date){
        self.currentDate = date
        self.startDate = date.startOfDay
        self.endDate = date.endOfDay
        loadData()
        refresh()
    }
    
    func refresh(){
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        mainController.dateText = formatter.string(from: currentDate)
        mainController.tasksData = currentTasks
        mainController.eventsData = currentEvents
        mainController.notesData = currentNotes
    }
}
