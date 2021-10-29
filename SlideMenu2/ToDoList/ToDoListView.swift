//
//  ToDoListView.swift
//  SlideMenu2
//
//  Created by Mher Melkonyan on 10/29/21.
//

import SwiftUI

struct ToDoListView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: ToDoListItem.getallToDoListItems()) var items: FetchedResults<ToDoListItem>
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("New Item")) {
                    HStack {
                        TextField("Enter new item...", text: $text)
                        
                        Button(
                            action: {
                                let newItem = ToDoListItem(context: context)
                                newItem.name = text
                                newItem.createdAt = Date()
                                
                                do {
                                    try context.save()
                                } catch {
                                    print(error)
                                }
                                
                                text = ""
                            },
                            label: {
                                Text("Save")
                            }
                        )
                        .foregroundColor(Color.blue)
                        .disabled(text == "")
                    }
                }
                Section {
                    ForEach(items) { toDoListItem in
                        VStack(alignment: .leading) {
                            Text(toDoListItem.name!)
                                .font(.headline)
                            Text("\(toDoListItem.createdAt!)")
                        }.contextMenu {
                            Button(action: {
                                self.delete(note: toDoListItem)
                            }) {
                                HStack {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                            Button(action: {}) {
                                HStack {
                                    Text("Favorite")
                                    Image(systemName: "star")
                                }
                            }
                        }
                    }.onDelete(perform: { indexSet in
                        guard let index = indexSet.first else { return }
                        let itemsToDelete = items[index]
                        context.delete(itemsToDelete)
                        do {
                            try context.save()
                        } catch {
                            print(error)
                        }
                    })
                }
            }
            .navigationTitle("To Do List")
        }
    }
    
    private func delete(note: ToDoListItem) {
        self.context.delete(note)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
