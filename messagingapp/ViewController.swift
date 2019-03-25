//
//  ViewController.swift
//  messagingapp
//
//  Created by Corey Townsend on 3/10/19.
//  Copyright © 2019 Corey Townsend inc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var postData = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
        //set the database reference
        ref = Database.database().reference()
        
        //Retrieve the post and listen for changes
     databaseHandle =  ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            //Code to execute when child is added under "Posts"
            //take the value from the snap shot and add it to the postData array
       
        // try to convert the value of data to a string
        let post = snapshot.value as? String
        
        if let actualPost = post{
            //append data to posts data array
        self.postData.append(actualPost)
            //reload tableview
            self.tableView.reloadData()
        }
        })
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        
        return cell!
    }
}

