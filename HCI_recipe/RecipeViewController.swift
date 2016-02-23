//
//  RecipeViewController.swift
//  HCI_recipe
//
//  Created by Jie Tan on 2/15/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit


class RecipeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {


    @IBOutlet var ingredientView: UITableView!
    @IBOutlet var stepView: UITableView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var flavorLabel: UILabel!
    @IBOutlet var ingredientLabel: UILabel!
    @IBOutlet var stepLabel: UILabel!
    @IBOutlet weak var caloryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var anotherNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    var testRecipe = Recipe!()
    var thisRecipe = Recipe(name:"Sweat and Sour Chicken",photo:UIImage(named: "SweetSour_Chicken")!, description: "")!
    var ingredients = ["Chicken","Sesame","Ketchup","Sugar"]
    var dosages = ["500g","1tsp","2Tsp","1Tsp"]
    var cookingtime = 30
    var flavor = "Sweet"
    var calorie = 300
    var stepTitle = ["Step 1","Step 2"]
    var stepDescription = ["this is step 1","this is step 2"]
    var stepPhoto = [UIImage(named: "SweetSour_Chicken")!,UIImage(named: "SweetSour_Chicken")!]
    var stepTip = ["Tips for step1","Tips for step2"]
    var stepReminder = ["Chicken:500g","Ketchup:2Tsp\nSugar:1Tsp"]
    var stepTimer = [5,10]
    
    var timer: NSTimer!
    
    func fireCellsUpdate() {
        let notification = NSNotification(name: "CustomCellUpdate", object: nil)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ScrollView.contentSize.height = 2000
        
        nameLabel.text = testRecipe.name
        self.recipeImage.image = testRecipe.photo
        anotherNameLabel.text = testRecipe.name
        descriptionLabel.text = testRecipe.description
        
        timeLabel.numberOfLines = 0
        timeLabel.frame = CGRectMake(0, 0, 65,50)
        timeLabel.text = "Time\n\(cookingtime)mins"
        //timeLabel.layer.borderWidth = 0.5
        //timeLabel.layer.borderColor = UIColor.blackColor().CGColor
        flavorLabel.numberOfLines=0
        flavorLabel.frame = CGRectMake(0, 0, 65,50)
        flavorLabel.text = "Flavor\n"+flavor
        caloryLabel.numberOfLines=0
        caloryLabel.frame = CGRectMake(0, 0, 65,50)
        caloryLabel.text = "Calorie\n\(calorie)K"
        
        //self.timer = NSTimer(timeInterval: 1.0, target: self, selector: Selector("fireCellsUpdate"), userInfo: nil, repeats: true)
        //NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
        
    }
    var clicked = false
    @IBAction func likeit(sender: AnyObject) {
        if (clicked==false){
            likeButton.setImage(UIImage(named: "liked"), forState: UIControlState.Normal)
            clicked = true
        } else{
            likeButton.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            clicked = false
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ingredientView{
            return ingredients.count
        } else {
            return stepTitle.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == ingredientView{
            let cell = self.ingredientView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! IngredientCell
            cell.ingredientName.text = ingredients[indexPath.row]
            cell.ingredientDosage.text = dosages[indexPath.row]
            return cell
        } else {
            let cell = self.stepView.dequeueReusableCellWithIdentifier("stepcell", forIndexPath: indexPath) as! StepTableViewCell
            cell.stepPic.image = stepPhoto[indexPath.row]
            cell.stepTitle.text = stepTitle[indexPath.row]
            cell.stepDescription.text = stepDescription[indexPath.row]
            cell.tipText.text = stepTip[indexPath.row]
            cell.stepReminder.text = stepReminder[indexPath.row]
            cell.stepReminder.numberOfLines = 0
            cell.timerLabel.text = String(format: "%02d:%02d",stepTimer[indexPath.row],0)
            cell.startButton.tag = stepTimer[indexPath.row]
            cell.startButton.addTarget(self, action: "starttimer:", forControlEvents: .TouchUpInside)
            //cell.restartButton.tag = stepTimer[indexPath.row]
            //cell.restartButton.addTarget(self, action: "restart:", forControlEvents: .TouchUpInside)
            //cell.timeInterval = NSTimeInterval(stepTimer[indexPath.row])
            cell.tipButton.tag = indexPath.row
            cell.tipButton.addTarget(self, action: "showtip:", forControlEvents: .TouchUpInside)
            return cell
        }
        
    }
    @IBAction func startimer(sender: UIButton){
        
    }

    var selectedIndexPath : NSIndexPath?

    @IBAction func showtip(sender: UIButton){
        let thisIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        
        let previousIndexPath = selectedIndexPath
        if thisIndexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = thisIndexPath
        }
        
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            self.stepView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }

    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == stepView{
            (cell as! StepTableViewCell).watchFrameChanges()

        }
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == stepView{
            (cell as! StepTableViewCell).ignoreFrameChanges()
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in stepView.visibleCells as! [StepTableViewCell] {
            cell.ignoreFrameChanges()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == stepView{
            if indexPath == selectedIndexPath {
                return StepTableViewCell.expandedHeight
            } else {
                return StepTableViewCell.defaultHeight
            }
        } else{
            return 44
        }
        
    }


    @IBAction func gotoOverview(sender: UIButton) {
        ScrollView.contentOffset = CGPointMake(0,0)
    }
    
    @IBAction func gotoIngredient(sender: UIButton) {
        
        ScrollView.contentOffset = CGPointMake(0,ingredientLabel.frame.minY)
    }
    @IBAction func gotoStep(sender: UIButton) {
        ScrollView.contentOffset = CGPointMake(0,stepLabel.frame.minY)
    }

}

