//
//  ToDoListItem.swift
//  SlideMenu2
//
//  Created by Mher Melkonyan on 10/29/21.
//

import Foundation
import CoreData

class ToDoListItem: NSManagedObject, Identifiable {
    @NSManaged var name: String?
    @NSManaged var createdAt: Date?
}

extension ToDoListItem {
    static func getallToDoListItems() -> NSFetchRequest<ToDoListItem> {
        let request: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest() as! NSFetchRequest<ToDoListItem>
        
        let sort = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sort]
        
        return request
    }
}
