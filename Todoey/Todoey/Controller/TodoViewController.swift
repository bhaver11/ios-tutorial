//
//  ViewController.swift
//  Todoey
//
//  Created by Synerg IITBombay on 26/05/20.
//  Copyright © 2020 Synerg IITBombay. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import ChameleonFramework

class TodoViewController: SwipeTableViewController  {
    
    let realm = try! Realm()
    
    var todoList:Results<Item>?
    var origBarColor:UIColor?
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var navTitle: UINavigationItem!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var category:Category? {
        didSet{
            loadDataFromStorage()
            navTitle.title = category?.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation Controller Not Found")
        }
        guard let barColor = UIColor(hexString: category!.color) else{ fatalError()
        }
        origBarColor = navBar.barTintColor
        navBar.barTintColor = barColor
        navBar.tintColor = ContrastColorOf(barColor, returnFlat: true)
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(barColor, returnFlat: true)]
        print("search bar")
        searchBar.barTintColor = barColor
        searchBar.searchTextField.backgroundColor = UIColor.white
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let navBar = navigationController!.navigationBar
        navBar.barTintColor = origBarColor
        navBar.tintColor = ContrastColorOf(origBarColor!, returnFlat: true)
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBar.tintColor, returnFlat: true)]
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellp = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = todoList?[indexPath.row] {
            cellp.textLabel?.text = item.title
            cellp.accessoryType = item.done ? .checkmark : .none
            if let color = UIColor(hexString: self.category!.color)?.darken(byPercentage: CGFloat(indexPath.row)/CGFloat(self.todoList!.count)){
                cellp.backgroundColor = color
                cellp.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)

            }
            
        }else{
            cellp.textLabel?.text = "No Items Added Yet"
        }
        return cellp
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath)
        
        if let item = todoList?[indexPath.row] {
            do {
                try self.realm.write{
                    item.done = !item.done
                }
            }catch {
                print("Error updating status \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addNewTodo(_ sender: UIBarButtonItem) {
        var newTodoTextField:UITextField = UITextField()
        let alert = UIAlertController(title: "Add new Todo", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("new added")
            print(newTodoTextField.text!)
            if let catg = self.category{
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = newTodoTextField.text!
                        newItem.done = false
                        newItem.created = Date()
                        catg.items.append(newItem)
                    }
                    
                }
                catch{
                    print("Error adding new item \(error)")
                }
                
            }
            //newItem.parentCategory = self.category
            //self.todoList.append(newItem)
           // self.saveDataToStorage(item: newItem)
            //self.defaults.set(self.todoList, forKey: "TodoListArray")
            self.tableView.reloadData()
        }

        alert.addTextField { (textField) in
            textField.placeholder = "Enter a new Todo Item"
            newTodoTextField = textField
        }
        alert.addAction(action)
        present(alert, animated: true) {
            print("complete")
        }
    }
    
//    func saveDataToStorage(item: Item){
//        do {
//            try realm.write{
//                realm.add(item)
//            }
//        }catch {
//            print("Error saving context \(error)")
//        }
//    }
    
    func loadDataFromStorage(){

        todoList = category?.items.sorted(byKeyPath: "created",ascending: false)
        tableView.reloadData()
    }
    
    override func deleteFunction(indexPath: IndexPath) {
         if let toDelete = self.todoList?[indexPath.row]{
              do{
                  try self.realm.write{
                      self.realm.delete(toDelete)
                  }
              }catch{
                  print("Error deleting cell \(error)")
              }
        }
    }

}

extension TodoViewController:UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoList = todoList?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "created", ascending: false)
        self.tableView.reloadData()
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            loadDataFromStorage()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }else{
            searchBarSearchButtonClicked(searchBar)
        }
    }
}

