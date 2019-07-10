//
//  JokeViewController.swift
//  APIHW
//
//  Created by SESP Walkup on 7/9/19.
//  Copyright © 2019 Alexander Yu. All rights reserved.
//

import UIKit

class JokeViewController: UITableViewController {
    
    var type = ""
    var knownTypes = [String]()
    var jokes = [[String: String]]()
    var setUp = ""
    var punchLine = ""
    
    override func viewDidLoad() {
        selection()
        super.viewDidLoad()
        self.title = "Random Jokes"
    }
    
    func selection() {
        for joke in jokes {
            if joke["type"] != type {
                jokes.remove(at: jokes.firstIndex(of: joke)!)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let joke = jokes[indexPath.row]
        cell.textLabel?.text = joke["setup"]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = tableView.indexPathForSelectedRow?.row
        setUp = jokes[index!]["setup"]!
        punchLine = jokes[index!]["punchline"]!
        let dvc = segue.destination as! FinalViewController
        dvc.setUP = setUp
        dvc.punchline = punchLine
    }
}
