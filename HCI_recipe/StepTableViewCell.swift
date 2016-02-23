//
//  StepTableViewCell.swift
//  HCI_recipe
//
//  Created by Jie Tan on 2/18/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit


class StepTableViewCell: UITableViewCell {

    @IBOutlet var stepPic: UIImageView!
    @IBOutlet var stepTitle: UILabel!
    @IBOutlet var stepDescription: UILabel!
    @IBOutlet var tipButton: UIButton!
    @IBOutlet var tipText: UILabel!
    @IBOutlet var reminderView: drawUIView!
    @IBOutlet var stepReminder: UILabel!
    @IBOutlet var timerView: drawUIView!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var startButton: UIButton!

    
    var timeInterval: NSTimeInterval = 0 {
        didSet {
            self.timerLabel.text = "\(timeInterval)"
        }
    }
    
    func updateUI() {
        if self.timeInterval > 0 {
            --self.timeInterval
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector("updateUI"), name: "CustomCellUpdate", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    var isObserving = false;
    class var expandedHeight: CGFloat { get { return 330 } }
    class var defaultHeight: CGFloat  { get { return 300  } }
    
    func checkHeight() {
        tipText.hidden = (frame.size.height < StepTableViewCell.expandedHeight)
    }
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.New, NSKeyValueObservingOptions.Initial], context: nil)
            isObserving = true;
        }
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }

}
