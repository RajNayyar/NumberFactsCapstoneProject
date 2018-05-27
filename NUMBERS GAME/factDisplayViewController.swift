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
    
    
    var fact = String()
   var result:[String] = []
     var facts: [NSManagedObject] = []
    var hub = String()
    var type = String()
        var url = URL(string: "")
    var flag = 0
    
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
                        self.factLabel.text = self.fact
                        if(self.flag==0)
                        {
                            self.save(name: self.fact)
                            self.flag = 0
                        }
                        print(self.facts)
                        print("gap gap")
                    }
                    
                }
            }
    }
    
    
    func get_data(_ completion: @escaping (_ done: [String]? , _ error: String?) -> Void){
        
        
        parseJSON(index: hub, completion: {resultArray, error, fact in
            if error != nil{
                completion(nil,error) ///////
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
    
    
    
    
    
    func parseJSON(index: String, completion: @escaping (_ tableArray:[String]?,_ error:String?,_ fact:String?) -> ()) {
        
        if(type == "math")
        {
             url = URL(string: "http://numbersapi.com/\(index)/math?json")
        }
        else if(type == "trivia")
        {
            url = URL(string: "http://numbersapi.com/\(index)?json")
        }
        else if(type == "random")
        {
             url = URL(string: "http://numbersapi.com/random?json")
        }
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            print("working 1")
            guard error == nil else {
                self.flag = 1
                let alert = UIAlertController(title: "Alert", message: "Network error", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                completion(nil,error as? String,self.fact)
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            guard let parsedata = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            if let text = parsedata["text"] as? String {
                self.result.append(text)
                self.fact = text
                print(self.fact)
                print("working 2")
            }
            
            completion (self.result,nil,self.fact)
        }
        
        task.resume()
        
        
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




