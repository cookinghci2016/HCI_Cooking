
//  MeatController.swift
//  HCI_recipe
//
//  Created by allen woo on 2/22/16.
//  Copyright © 2016 Jie Tan. All rights reserved.


import UIKit

class MeatController: UIViewController,UITableViewDataSource {
    var allmeat = [IngridentTypes]()
    // Dictionay to store selected item
    var selected_item =  [Int: String]()
    
    @IBOutlet weak var tableView: UITableView!
    // Store Search 
    var filteredMeat = [IngridentTypes]()
    let searchController = UISearchController(searchResultsController: nil)
    

    func filterContentForSearchText(searchText: String, scope: String = "All"){
        filteredMeat = allmeat.filter{ meat in return meat.Ingtype.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView!.reloadData();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMeat()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    
    }

    
    // MARK:  Inititialization
    func loadSampleMeat() {
        let beef_sub = ["beef_chuck", "beef_loin", "beef_rib","beef_round", "beef_shank"]
        let beef = IngridentTypes(type : "Beef", photo: UIImage(named: "Ox"), sub_names: beef_sub)!
        
        let chick_sub = ["chicken_breast", "chicken_cutlets", "chicken_tender","chicken_wings","beef_shank"]
        let chick = IngridentTypes(type : "Chick", photo: UIImage(named: "Chicken"), sub_names: chick_sub)!

        let pork_sub = ["beef_chuck", "beef_loin", "beef_rib","beef_round", "beef_shank"]
        let pork = IngridentTypes(type : "Pork", photo: UIImage(named: "Pig"), sub_names: pork_sub)!

        let lamb_sub = ["beef_chuck", "beef_loin", "beef_rib","beef_round", "beef_shank"]
        let lamb = IngridentTypes(type : "Lamb", photo: UIImage(named: "Sheep"), sub_names: lamb_sub)!

        let duck_sub = ["beef_chuck", "beef_loin", "beef_rib","beef_round", "beef_shank"]
        let duck = IngridentTypes(type : "Duck", photo: UIImage(named: "Duck"), sub_names: duck_sub)!

        allmeat += [beef, chick, pork, lamb, duck]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: Table view data source
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredMeat[section].Ingtype
        }
        else {
            return allmeat[section].Ingtype
        }
    }

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
//        return allmeat.count
        if searchController.active && searchController.searchBar.text != ""{
            return filteredMeat.count
        } else {
            return allmeat.count
        }
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
        // Get current row and assign item numbers
        //let cur_meat = allmeat[indexPath.section]
        let cur_meat : IngridentTypes
        if searchController.active && searchController.searchBar.text != ""{
            cur_meat = filteredMeat[indexPath.section]
        } else {
            cur_meat = allmeat[indexPath.section]
        }
        
        
        // print("I am here, count =")

        cell.num_sec = cur_meat.sub_imgs.count;
        // print(indexPath.section)
        // Assign image array to UItable View Cell; Including the Image for ingredient, ox, pork, chicken and etc.
//        cell.dic = allmeat[indexPath.section].sub_imgs
//        cell.nm = allmeat[indexPath.section].sub_names
        
        print(String(searchController.active))
        print(" Next ")
        print(searchController.searchBar.text)
        print("Section value = ")
        print(indexPath.section)
        if searchController.active && searchController.searchBar.text != ""{
            //cur_meat = filteredMeat[indexPath.section]
            
            cell.dic = filteredMeat[indexPath.section].sub_imgs
            cell.nm = filteredMeat[indexPath.section].sub_names
        } else {
            cell.dic = allmeat[indexPath.section].sub_imgs
            cell.nm = allmeat[indexPath.section].sub_names
        }
        return cell
    }
    

    
    
//    var categories = ["Beef", "Chicken", "Pork", "Lamb", "Duck"]
//
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return categories[section]
//    }
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return categories.count
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
//        return cell
//    }
//    

    
    // Close Key board when finish entering
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MeatController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
