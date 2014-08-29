//
//  SettingsViewController.swift
//  tips
//
//  Created by Dan Schultz on 8/26/14.
//  Copyright (c) 2014 Dan Schultz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var percentagesControl: UISegmentedControl!
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    var tipPercentages: [Double] {
        return appDelegate.settings.defaultPercentages
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tipIndex = find(tipPercentages, appDelegate.settings.tipAmount) {
            percentagesControl.selectedSegmentIndex = tipIndex
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleCancel(sender: AnyObject) {
        dismiss()
    }

    @IBAction func handleSave(sender: AnyObject) {
        let tipAmount = tipPercentages[percentagesControl.selectedSegmentIndex]
        appDelegate.settings.tipAmount = tipAmount
        dismiss()
    }
    
    private func dismiss() {
        var navigationController = presentingViewController as UINavigationController;
        var tipController = navigationController.topViewController as ViewController;
        
        tipController.transitionIn()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
