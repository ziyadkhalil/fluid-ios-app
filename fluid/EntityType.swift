//
//  EntityType.swift
//  fluid
//
//  Created by Ziyad Khalil on 5/8/19.
//  Copyright © 2019 Ziyad Khalil. All rights reserved.
//

enum EntityType {
    case task
    case note
    case event
}

extension EntityType {
    func toString() -> String {
        switch(self){
        case .task:
            return "task"
        case .event:
            return "event"
        case .note:
            return "note"
        }
    }
}
