//
//  FinalViewController.swift
//  APIHW
//
//  Created by SESP Walkup on 7/9/19.
//  Copyright © 2019 Alexander Yu. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    @IBOutlet weak var setUp: UILabel!
    @IBOutlet weak var punchLine: UILabel!
    
    var setUP = ""
    var punchline = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUp.text = setUP
        punchLine.text = punchline
    }
}
