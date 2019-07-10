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
    let apiKey = ""
    var knownTypes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
    }
    
    func parse(json: JSON) {
        for result in json.arrayValue {
            print("parse")
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
    
    func loadError() {
        let alert = UIAlertController(title: "LoadingError", message: "There was a problem loading the news feed", preferredStyle: .actionSheet)
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
        print(type)
        return cell
    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let dvc = segue.destination as! ArticlesViewController
    //        let index = tableView.indexPathForSelectedRow?.row
    //        dvc.source = sources[index!]
    //        dvc.apiKey = apiKey
    //    }
}
