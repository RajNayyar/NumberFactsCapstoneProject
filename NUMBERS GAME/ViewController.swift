//
//  ViewController.swift
//  NUMBERS GAME
//
//  Created by Rajpreet on 12/05/18.
//  Copyright © 2018 Rajpreet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var GO: UIButton!
       @IBOutlet weak var mathAction: UIButton!
    var tableArray = [String] ()
   var S: String = "hello"
    var flag: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
         numberField.text = "Number"
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func goAction(_ sender: Any) {
    if(numberField.text == "Number" || numberField.text=="")
    {
    Alert()
    }
    else
    {flag = 1}
    }
    
    @IBAction func Instructions(_ sender: Any) {
        let alert = UIAlertController(title: "Instructions", message: "1. Enter a number in the text box. \n2. Press the yellow 'BULB' button to get a trivia fact!. \n3. Press the Red 'math' button to get a math fact. \n 4. Press the blue 'Dice' button to get a Random Fact!. \n5. Press the 'History' Button on the upper right corner inorder to see all the searched FACTS!!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func enterNumber(_ sender: Any) {
    
    }
    
    @IBAction func historyButton(_ sender: Any) {
        flag = 0
    }
    
    @IBAction func mathAction(_ sender: Any) {
        if(numberField.text == "Number" || numberField.text=="")
        {
            Alert()
        }
        else
        {flag = 2}
    }
    
    @IBAction func randomButton(_ sender: Any) {
        print("working button")
        flag = 3
        let factDisplayViewController = self.storyboard?.instantiateViewController(withIdentifier: "factDisplayViewController") as! factDisplayViewController
        factDisplayViewController.type = "random"
        factDisplayViewController.hub = numberField.text!
        self.navigationController?.pushViewController(factDisplayViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(flag==1)
        {
            let sg = segue.destination as! factDisplayViewController
            sg.hub = numberField.text!
            sg.type = "trivia"
            flag = 0
        }
        else if(flag==2)
        {
            let sg = segue.destination as! factDisplayViewController
            sg.hub = numberField.text!
            sg.type = "math"
            flag = 0
        }
    }
    
 
    func Alert(){
        let alert = UIAlertController(title: "Alert", message: "Enter a Number!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

