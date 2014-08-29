//
//  ViewController.swift
//  tips
//
//  Created by Dan Schultz on 8/26/14.
//  Copyright (c) 2014 Dan Schultz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var percentageControl: UISegmentedControl!
    
    @IBOutlet weak var billAmountGroup: UIView!
    @IBOutlet weak var tipAmountGroup: UIView!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var tipGroup: UIView!
    @IBOutlet weak var totalGroup: UIView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    var tipPercentages: [Double] {
        return appDelegate.settings.defaultPercentages
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tipLabel.text = "$0.00";
        totalLabel.text = "$0.00";
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tipIndex = find(tipPercentages, appDelegate.settings.tipAmount) {
            percentageControl.selectedSegmentIndex = tipIndex
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func handleBillEditingChanged(sender: AnyObject) {
        var tipPercentage = tipPercentages[percentageControl.selectedSegmentIndex]
        
        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func handleTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func handleSettingsTap(sender: AnyObject) {
        var settingsViewController = storyboard.instantiateViewControllerWithIdentifier("SettingsViewController") as UIViewController
        transitionOut(settingsViewController)
    }
    
    func transitionIn() {
        transitionView(billAmountGroup,
            direction: TransitionDirection.IN,
            delay: 0,
            completion: nil)
        
        transitionView(tipAmountGroup,
            direction: TransitionDirection.IN,
            delay: 0.05,
            completion: nil)
        
        transitionView(separator,
            direction: TransitionDirection.IN,
            delay: 0.1,
            completion: nil)
        
        transitionView(tipGroup,
            direction: TransitionDirection.IN,
            delay: 0.15,
            completion: nil)
        
        transitionView(totalGroup,
            direction: TransitionDirection.IN,
            delay: 0.2,
            completion: nil)
    }
    
    private func transitionOut(to: UIViewController) {
        transitionView(billAmountGroup,
            direction: TransitionDirection.OUT,
            delay: 0,
            completion: nil)
        
        transitionView(tipAmountGroup,
            direction: TransitionDirection.OUT,
            delay: 0.05,
            completion: nil)
        
        transitionView(separator,
            direction: TransitionDirection.OUT,
            delay: 0.1,
            completion: nil)
        
        transitionView(tipGroup,
            direction: TransitionDirection.OUT,
            delay: 0.15,
            completion: nil)
        
        transitionView(totalGroup,
            direction: TransitionDirection.OUT,
            delay: 0.2,
            completion: { (finished: Bool) in
                self.presentViewController(to, animated: true, completion: nil)
            })
    }
    
    private func transitionView(view: UIView, direction: TransitionDirection, delay: NSTimeInterval, completion: ((Bool) -> Void)?) {
        UIView.animateWithDuration(0.4,
            delay: delay,
            options: UIViewAnimationOptions.CurveEaseInOut & UIViewAnimationOptions.TransitionNone,
            animations: {
                switch (direction) {
                    case TransitionDirection.OUT:
                        view.transform.tx = -200;
                        view.alpha = 0;
                    case TransitionDirection.IN:
                        view.transform.tx = 0;
                        view.alpha = 1;
                }
                
            },
            completion: completion)
    }
}

enum TransitionDirection {
    case IN
    case OUT
}

