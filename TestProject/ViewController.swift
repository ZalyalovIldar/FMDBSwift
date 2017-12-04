//
//  ViewController.swift
//  TestProject
//
//  Created by Ildar Zalyalov on 04.12.2017.
//  Copyright © 2017 Ildar Zalyalov. All rights reserved.
//

import UIKit
import FMDB

class ViewController: UIViewController {
    lazy var db: FMDatabase = {
       
        return FMDatabase(path: "")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

