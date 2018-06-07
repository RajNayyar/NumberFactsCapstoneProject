//
//  factDisplayViewController.swift
//  NUMBERS GAME
//
//  Created by Rajpreet on 13/05/18.
//  Copyright © 2018 Rajpreet. All rights reserved.
//

import UIKit
import CoreData

class factDisplayViewController: UIViewController {

    @IBOutlet weak var inid: UIActivityIndicatorView!
    @IBOutlet weak var factLabel: UILabel!
    
    let obj = Network()
    
  
     var facts: [NSManagedObject] = []
    var hub = String()
    var type = String()
        var url = URL(string: "")
   
    
    override func viewDidLoad() {
         self.networkingAPI()
         super.viewDidLoad()
    
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
    }
    
    func networkingAPI(){
   
            self.get_data(){ (result,error) in
                if error != nil {
                    self.Alert()
                    return
                }
                else{
                    DispatchQueue.main.async {
                        self.inid.isHidden = true
                        self.factLabel.text = fact
                        if(flag==0)
                        {
                            self.save(name: fact)
                            flag = 0
                        }
                        print(self.facts)
                        print("gap gap")
                    }
                }
            }
    }
    
    
    func get_data(_ completion: @escaping (_ done: [String]? , _ error: String?) -> Void){
        
        
        obj.parseJSON(index: hub, completion: {resultArray, error, fact in
            
            if error != nil{
                let alert = UIAlertController(title: "Alert", message: "Network Error", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                completion(nil,error)
                return
            }

            else{
                DispatchQueue.main.async {
                    print("DONE")
                    completion(resultArray,nil)
                }
            }
        })
    }
    
    
    func save(name: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Fact", in: managedContext)!
        
        let factname = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //3
        factname.setValue(name, forKeyPath: "fact")

        //4
        do{
            try managedContext.save()
            facts.append(factname)
        }catch let error as NSError {
            print("Could not save \(error),\(error.userInfo)")
        }
        
    }
    
    func Alert(){
        let alert = UIAlertController(title: "Alert", message: "Enter a Number!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    }




