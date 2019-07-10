//
//  ViewController.swift
//  Currency Exchange API
//
//  Created by SESP Walkup on 7/9/19.
//  Copyright © 2019 Alexander Yu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var sources = [[String: String]]()
    var knownTypes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
        self.title = "Random Jokes"
        let query = "https://official-joke-api.appspot.com/random_ten"
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data (contentsOf: url){
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    
    func parse(json: JSON) {
        for result in json.arrayValue {
            let types = result["type"].stringValue
            let setup = result["setup"].stringValue
            let punchline = result["punchline"].stringValue
            let source = ["type": types, "setup": setup, "punchline": punchline] as [String : String]
            sources.append(source)
            if !knownTypes.contains(types) {
                knownTypes.append(types)
            }
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    @IBAction func onTappedRefresh(_ sender: Any) {
        sources.removeAll()
        super.viewDidLoad()
        let query = "https://official-joke-api.appspot.com/random_ten"
        print("succeed")
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data (contentsOf: url){
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    
    func loadError() {
        let alert = UIAlertController(title: "LoadingError", message: "There was a problem loading the jokes feed", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return knownTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let type = knownTypes[indexPath.row]
        cell.textLabel?.text = type
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! JokeViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.type = knownTypes[index!]
        dvc.jokes = sources
    }
}
