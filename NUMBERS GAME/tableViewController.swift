//
//  tableViewController.swift
//  NUMBERS GAME
//
//  Created by Rajpreet on 14/05/18.
//  Copyright © 2018 Rajpreet. All rights reserved.
//

import UIKit
import CoreData

class tableViewController: UITableViewController {
    
    var facts: [NSManagedObject] = []
    
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.reloadData();
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Fact")
        
        //3
        do {
            facts = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        print("gap")
        print(facts)
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return facts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        let fact = facts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! tableViewCell
        //cell.textLabel?.text = person;
        cell.texttext?.text = fact.value(forKeyPath: "fact") as? String
       // print("hellvfjdvacjadja                 \n", cell.textLabel?.text)
        return cell
    }
 

  

}
