//
//  ViewController.swift
//  Demo Application
//
//  Created by Daniele Margutti on 09/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import UIKit
import SwiftDate

class ViewController: UIViewController {

    @IBOutlet weak var colloquialTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colloquialTimeLabel.text = try? Date().addingTimeInterval(-3600 * 24 * 20).colloquialSinceNow(unitStyle: .short).colloquial
    }
}

