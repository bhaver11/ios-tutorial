//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Synerg IITBombay on 30/06/20.
//  Copyright © 2020 Synerg IITBombay. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var categories:Results<Category>?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromStorage()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false``
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var newTodoTextField:UITextField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            print("new added")
            print(newTodoTextField.text!)
            let newCategory = Category()
            newCategory.name = newTodoTextField.text!
            newCategory.color = UIColor.randomFlat().hexValue()
           // self.categories.append(newCategory)
            self.saveDataToStorage(category: newCategory)
            //self.defaults.set(self.todoList, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter a new Category"
            newTodoTextField = textField
        }
        alert.addAction(action)
        present(alert, animated: true) {
            print("complete")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let catg = categories?[indexPath.row] {
            cell.textLabel?.text = catg.name
            cell.backgroundColor = UIColor(hexString: catg.color)
            cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
            cell.accessoryType = .disclosureIndicator
            cell.accessoryView?.backgroundColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        }else {
            cell.textLabel?.text = "No Categories Added"
        }
        //cell.backgroundColor  = UIColor(
        //cell.textLabel?.text = item.name
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func saveDataToStorage(category: Category){
        do {
            try realm.write{
                realm.add(category)
            }
        }catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadDataFromStorage(){
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func deleteFunction(indexPath: IndexPath) {
         if let toDelete = self.categories?[indexPath.row]{
              do{
                  try self.realm.write{
                      self.realm.delete(toDelete)
                  }
              }catch{
                  print("Error deleting cell \(error)")
              }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationVC = segue.destination as! TodoViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            destinationVC.category =  categories?[indexPath!.row]
        }
    }

}
