//
//  TableViewController.swift
//  hw3 - MRT Stations
//
//  Created by JACK on 2016/12/26.
//  Copyright © 2016年 JACK. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewController: UITableViewController {
    
    var mrtLine: [String: [Double]] = [
        "文湖線": [158, 101, 46],
        "淡水信義線":[203, 44, 48],
        "新北投支線":[248, 144, 165],
        "松山新店線":[0, 119, 73],
        "小碧潭支線":[206, 220, 0],
        "中和新蘆線":[255, 163, 0],
        "板南線":[0, 94, 184],
        "貓空纜車":[119, 185, 51],
        ]
    
    func readJason() -> JSON{
        
        if let path = Bundle.main.path(forResource: "MRT", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    //print("jsonData:\(jsonObj)")
                    return jsonObj
                }
                else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        else {
            print("Invalid filename/path.")
        }
        
        return JSON.null
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return readJason().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        // Configure the cell...
        
        let jasonData = readJason()
        
        cell.stationName.text = jasonData[(indexPath as NSIndexPath).row]["name"].stringValue
        
        if(jasonData[(indexPath as NSIndexPath).row]["lines"].dictionaryValue.count == 2 )
        {
            var c = 0
            
            for name in jasonData[(indexPath as NSIndexPath).row]["lines"].dictionaryValue.keys{
                if(c==0){
                    cell.lineName1.text = jasonData[(indexPath as NSIndexPath).row]["lines"].dictionaryValue[name]?.stringValue
                    cell.lineName1.textColor = UIColor.white
                    c+=1
                    let a = (mrtLine[name]?[0])!/255
                    let b = (mrtLine[name]?[1])!/255
                    let c = (mrtLine[name]?[2])!/255
                    cell.lineName1.backgroundColor = UIColor(red: CGFloat(Double(a)), green: CGFloat(Double(b)), blue: CGFloat(Double(c)), alpha: 1.0)
                }
                else{
                    cell.lineName2.text = jasonData[(indexPath as NSIndexPath).row]["lines"].dictionaryValue[name]?.stringValue
                    cell.lineName2.textColor = UIColor.white
                    c=0
                    let a = (mrtLine[name]?[0])!/255
                    let b = (mrtLine[name]?[1])!/255
                    let c = (mrtLine[name]?[2])!/255
                    cell.lineName2.backgroundColor = UIColor(red: CGFloat(Double(a)), green: CGFloat(Double(b)), blue: CGFloat(Double(c)), alpha: 1.0)
                }
            }
        }
        else
        {
            cell.lineName1.text = jasonData[(indexPath as NSIndexPath).row]["lines"].dictionaryValue.values.first?.stringValue
            cell.lineName1.textColor = UIColor.white
            cell.lineName2.text = ""
            cell.lineName2.backgroundColor = UIColor.white
            let name =  jasonData[(indexPath as NSIndexPath).row]["lines"].dictionaryValue.keys.first
            let a = (mrtLine[name!]?[0])!/255
            let b = (mrtLine[name!]?[1])!/255
            let c = (mrtLine[name!]?[2])!/255
            cell.lineName1.backgroundColor = UIColor(red: CGFloat(Double(a)), green: CGFloat(Double(b)), blue: CGFloat(Double(c)), alpha: 1.0)
        }
        
        return cell
    }
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //
    //        return
    //    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let jasonData = readJason()
        
        if segue.identifier == "show" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let destinationController = segue.destination as! ViewController
                
                destinationController.name = jasonData[(indexPath as NSIndexPath).row]["name"].stringValue
                
                if(jasonData[(indexPath as NSIndexPath).row]["lines"].dictionaryValue.count == 2 )
                {
                    var c = 0
                    
                    for name in jasonData[(indexPath as NSIndexPath).row]["lines"].dictionaryValue.keys{
                        if(c==0){
                            destinationController.lineName1 = name
                            c+=1
                            let a = (mrtLine[name]?[0])!/255
                            let b = (mrtLine[name]?[1])!/255
                            let c = (mrtLine[name]?[2])!/255
                            destinationController.color1 = UIColor(red: CGFloat(Double(a)), green: CGFloat(Double(b)), blue: CGFloat(Double(c)), alpha: 1.0)
                        }
                        else{
                            destinationController.lineName2 = name
                            c=0
                            let a = (mrtLine[name]?[0])!/255
                            let b = (mrtLine[name]?[1])!/255
                            let c = (mrtLine[name]?[2])!/255
                            destinationController.color2 = UIColor(red: CGFloat(Double(a)), green: CGFloat(Double(b)), blue: CGFloat(Double(c)), alpha: 1.0)
                        }
                    }

                }
                else
                {
                    let name = jasonData[(indexPath as NSIndexPath).row]["lines"].dictionaryValue.keys.first
                    destinationController.lineName1 = name!
                    destinationController.lineName2 = ""
                    let a = (mrtLine[name!]?[0])!/255
                    let b = (mrtLine[name!]?[1])!/255
                    let c = (mrtLine[name!]?[2])!/255
                    destinationController.color1 = UIColor(red: CGFloat(Double(a)), green: CGFloat(Double(b)), blue: CGFloat(Double(c)), alpha: 1.0)
                    destinationController.color2 = UIColor.white
                }
                
                
            }
        }
        else
        {
            super.prepare(for: segue, sender: sender)
        }
    }
    
}
