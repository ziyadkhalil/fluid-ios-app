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
    var mainController: MainViewController!
    
    // -MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentDate()
        (self.viewControllers[0] as! MainViewController).navBarController = self
        initCoreData()
        setMainController()
    }
    
    ///Gets today's date and sets it into the app main control flow
    func getCurrentDate(){
        currentDate = Date()
        endDate = currentDate.endOfDay
        startDate = currentDate.startOfDay
    }
    
    ///Initialiazes coredata into the app then calls loadData()
    func initCoreData(){
        container = NSPersistentContainer(name: "fluid")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        loadData()
    }

    ///Fetches data from CoreData for the current date and puts them on different arrays: Tasks, notes and events.
    func loadData(){
        let request = Entity.createFetchRequest()
        request.predicate = NSPredicate(
            format: "(type == 'task') AND (date >= %@) AND (date <= %@)", argumentArray: [startDate , endDate])
        do {
            self.currentTasks = try container.viewContext.fetch(request)
        } catch {
            print("Fetch failed")
        }
        request.predicate = NSPredicate(
        format: "(type == 'event') AND (date >= %@) AND (date <= %@)", argumentArray: [startDate , endDate])
        do {
            self.currentEvents = try container.viewContext.fetch(request)
        } catch {
            print("Fetch failed")
        }
        request.predicate = NSPredicate(
        format: "(type == 'note') AND (date >= %@) AND (date <= %@)", argumentArray: [startDate , endDate])
        do {
            self.currentNotes = try container.viewContext.fetch(request)
        } catch {
            print("Fetch failed")
        }
    }
    
    ///saves a reference of MainViewController then refreshes the navBar Controller
    func setMainController(){
        mainController = (self.viewControllers[0] as! MainViewController)
        refresh()
    }
    
    
    /// Saves changes done to CoreData
    func saveDate(){
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    /// Adds a new entity to model then calls saveData() to save it to CoreData.
    ///
    /// - Parameters:
    ///   - mode: a mode that descriped the type of entity passed to be added
    ///   - value: value of the added entity
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
    
    
    /// returns an array of tasks, events or notes based on the mode passed to it
    ///
    /// - Parameter mode: a mode of type EntityType that descriped the current mode in DetailsViewController
    /// - Returns: array of entities
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
    
    
    /// updates current date of the app, when user changes it.
    ///
    /// - Parameter date: <#date description#>
    func setNewDate(date: Date){
        self.currentDate = date
        self.startDate = date.startOfDay
        self.endDate = date.endOfDay
        loadData()
        refresh()
    }
    
    /// Updates MainController Date Label and Data Arrays
    func refresh(){
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        mainController.dateText = formatter.string(from: currentDate)
        mainController.tasksData = currentTasks
        mainController.eventsData = currentEvents
        mainController.notesData = currentNotes
    }
}
