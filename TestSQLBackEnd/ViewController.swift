//
//  ViewController.swift
//  TestSQLBackEnd
//
//  Created by Greg Hughes on 4/21/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        guard let nameText = firstNameTextField.text, let lastNameText = lastNameTextField.text else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
        
        let url = URL(string: "urlString")!
        let person = Person(firstName: nameText, lastName: lastNameText)
        let params = ["firstName" : person.firstName, "lastName": person.lastName]
        
        do {
            
            let postData = try JSONSerialization.data(withJSONObject: params, options: .init())
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = postData
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: request) { (data, res, er) in
                if let error = er {
                    print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription) : \(#file) \(#line)")
                    return
                }
                if let data = data {
                    print("🚣🏻‍♀️ DATA", data )
                }
                if let response = res {
                    print("🎯 RESPONSE ", response)
                }
                
            }.resume()
            
        } catch let error {
            print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
            return
        }
    }
    
}

class Person : Codable{
    var firstName : String
    var lastName : String
    
    internal init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
