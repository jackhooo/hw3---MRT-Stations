//
//  ViewController.swift
//  hw3 - MRT Stations
//
//  Created by JACK on 2016/12/26.
//  Copyright © 2016年 JACK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var name:String!
    var lineName1:String!
    var lineName2:String!
    var color1:UIColor!
    var color2:UIColor!
    
    @IBOutlet weak var name2Label: UILabel!
    @IBOutlet weak var name1Label: UILabel!
    @IBOutlet weak var stationNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = name
        
        name1Label.text = lineName1
        name2Label.text = lineName2
        name1Label.textColor = UIColor.white
        name2Label.textColor = UIColor.white
        name1Label.backgroundColor = color1
        name2Label.backgroundColor = color2
        stationNameLabel.text = name
        
    }
}
