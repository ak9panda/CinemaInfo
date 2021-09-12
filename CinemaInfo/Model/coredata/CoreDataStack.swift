//
//  CoreDataStack.swift
//  CinemaInfo
//
//  Created by admin on 09/08/2021.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private init() {}
    
    var persistantContainer: NSPersistentContainer!
    
    var viewContext: NSManagedObjectContext {
        return persistantContainer.viewContext
    }
}
