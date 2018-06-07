import Foundation
import UIKit

class Network{
    

    func parseJSON(index: String, completion: @escaping (_ tableArray:[String]?,_ error:String?,_ fact:String?) -> ()) {

        if(realType == "math")
        {
            url = URL(string: "http://numbersapi.com/\(index)/math?json")
        }
        else if(realType == "trivia")
        {
            url = URL(string: "http://numbersapi.com/\(index)?json")
        }
        else if(realType == "random")
        {
            url = URL(string: "http://numbersapi.com/random?json")
        }
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            print("working 1")
            guard error == nil else {
              flag = 1

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
                result.append(text)
                fact = text
                print(fact)
                print("working 2")
            }
            
            completion (result,nil,fact)
        }
        
        task.resume()
    }
}
