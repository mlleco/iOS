//
//  ViewController2.swift
//  CRUD
//
//  Created by NSR on 2023-07-27.
//

import Foundation
import UIKit
import CoreData

class ViewController2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
   
    // Implement PickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataGender.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataGender[row]
    }
    
    // Declare the variables and tools

    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var pv: UIPickerView!
    @IBOutlet weak var tv: UITableView!
    let contextt = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[Persons]?
    let dataGender = ["Male", "Female"]
    
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtAge.delegate=self
        txtName.delegate=self
        tv.dataSource=self
        tv.delegate=self
        pv.dataSource=self
        pv.delegate=self
        
        self.lblName.text = "Person name is:..... "
        self.lblAge.text = "Age is:............. "
        self.lblGender.text = "Gender is:.......... "
        
       
        fetchPepole ()
    }
    
    // Method to save a new person with button + add new using alert Box

    @IBAction func btnAddAlert(_ sender: Any) {
        // Delclare Alert
        let alert = UIAlertController (title: "Add New Person", message: "What is their name", preferredStyle: .alert)
        alert.addTextField()
        
        // Create Alert Buttons
        let cancelBtn = UIAlertAction (title: "Cancel", style: .default){(action) in
            self.dismiss(animated: true)
        }
        let submittButton = UIAlertAction (title: "Add", style: .default){ [self](action) in
            let textF = alert.textFields![0]
            let newPerson = Persons(context: self.contextt)
            let row = pv.selectedRow(inComponent: 0)
            let val = self.dataGender[row]
            newPerson.age = 33
            newPerson.gender = val
            newPerson.name = textF.text
            
            do {
                ad.saveContext()
                print("User is added!")
                
                DispatchQueue.main.async {
                    self.tv.reloadData()
                }
            }
            self.fetchPepole()
        }
        alert.addAction(submittButton)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    // This method can fetch all informations from core database
    func fetchPepole (){
        do{
            let request = Persons.fetchRequest() as NSFetchRequest<Persons>
            
            // Filtering: If you want to get a specific name or anything unmark these 2 lines
            //let pred = NSPredicate (format: "name CONTAINS %@", "Hala Hajji Mlle")
            //request.predicate = pred
            
            // sorting: sort after name asceding or desc If you want to it unmark these 2 lines
            // let sort = NSSortDescriptor(key: "name", ascending: true)
            //  request.sortDescriptors = [sort]
            
            self.items = try contextt.fetch(request)
            DispatchQueue.main.async {
                self.tv.reloadData()
            }
            
        }catch{
            print("ERROR")
        }
    }
    
    // Method to save a new person with button blue
    @IBAction func btnAddNewPerson(_ sender: Any) {
        // validate the textField
        if (txtAge.text != "") && (txtName.text != ""){
            // Get pickerView selected row value
        let row = self.pv.selectedRow(inComponent: 0)
        let val = dataGender[row]
        //add new person
        let newPerson = Persons(context: context)
        
        newPerson.age = Int64 (txtAge.text ?? "") ?? 0
        newPerson.gender = val
        newPerson.name = String(txtName.text!)
   
                do {
                    ad.saveContext()
                    print("User is added!")
                    txtName.text = ""
                    txtAge.text = ""}
        }
        else
        {
            let alert = UIAlertController (title: "Warning!", message: "Fill all fields", preferredStyle: .alert)
          
            
            let cancelBtn = UIAlertAction (title: "Cancel", style: .default){(action) in
                self.dismiss(animated: true)
                self.fetchPepole()
            }
            alert.addAction(cancelBtn)
            self.present(alert, animated: true, completion: nil)
        }
       
        
        fetchPepole()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
     
}

// This method using tableView to return all information
    extension ViewController2: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.items?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
             let person = self.items![indexPath.row]
             cell.textLabel?.text =   (person.name)
            // If you want to put information in the label
             self.lblName.text = "Person name is: " + (person.name!)
             self.lblAge.text = "Age is: " + String(person.age)
             self.lblGender.text = "Gender is: " + (person.gender!)
            // Optional: do some codes or conditions
           /* if(lblGender.text == "Female"){
                print("YESSS")
            }
            else
            {
                print("Noooo")
            }*/
            return cell
            
        }
        
        // Function to edit any name by click on the row using alert Box
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let person = self.items![indexPath.row]
            self.lblName.text = "Person name is: " + (person.name!)
            self.lblAge.text = "Age is: " + String(person.age)
            self.lblGender.text = "Gender is: " + (person.gender!)
          // Alert
            let alert = UIAlertController (title: "Edit Person", message: "Edit name", preferredStyle: .alert)
            alert.addTextField()
            
            let cancelBtn = UIAlertAction (title: "Cancel", style: .default){(action) in
                self.dismiss(animated: true)
            }
            
            let saveBtn = UIAlertAction (title: "Save", style: .default){(action) in
                let textF = alert.textFields![0]
                person.name = textF.text
               
                
                do {
                   try self.contextt.save()
                 
                    print("User is Updated")
                }
                catch
                {
                    print("can't update the user.")
                }
                
                self.fetchPepole()
            }
            alert.addAction(saveBtn)
            alert.addAction(cancelBtn)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        // Function to delete any user by swipping
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction (style: .destructive, title: "Delete") { (action, view , CompletionHandler) in
                
               
                
                let personRemov = self.items! [indexPath.row]
                self.lblName.text = "Person name is: " + (personRemov.name!)
               self.lblAge.text = "Age is: " + String(personRemov.age)
               self.lblGender.text = "Gender is: " + (personRemov.gender!)
                self.contextt.delete(personRemov)
                
                do {
                    try self.contextt.save()
                    print("User is deleted")
                    // If you want to put information in the label
                    self.lblName.text = "Person name is:..... "
                    self.lblAge.text = "Age is:............. "
                    self.lblGender.text = "Gender is:.......... "
                }
                catch{
                    print("Can't Delete")
                }
                self.fetchPepole()
            }
                return UISwipeActionsConfiguration(actions: [action])
            }
    }
     

