//
//  ViewController.swift
//  GeoCalc
//
//  Created by Nav Dalmia on 5/23/18.
//  Copyright © 2018 Nav Dalmia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingsSelectionViewControllerDelegate
{
    var distUnits:String = "miles"
    var bearUnits:String = "degrees"
    
    func indicateSelection(dist: String, bear: String) {
        if(dist == "" && bear == "")
        {
            
        }
        else if(dist == "" && bear != "")
        {
            bearUnits = bear;
            recalculate()
        }
        else if(dist != "" && bear == "")
        {
            distUnits = dist;
            recalculate()
        }
        else
        {
        distUnits = dist;
        bearUnits = bear;
        recalculate()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "chooseSettings"
        {
            if let dest = segue.destination as? SettingsViewController
            {
                dest.delegate = self
            }
        }
    }
    

    @IBOutlet weak var latitude1: UITextField!
    
    @IBOutlet weak var latitude2: UITextField!
    
    @IBOutlet weak var longitude1: UITextField!
    
    @IBOutlet weak var longitude2: UITextField!
    
    @IBAction func calculatePressed(_ sender: Any) {
       
        var lt1 = false
        let lat1 = self.latitude1.text
        
            if lat1 != ""
            {
                lt1 = true
            }
        
        
        
        var lt2 = false
        let lat2 = self.latitude2.text
        
            if lat2 != ""
            {
                lt2 = true
            }
        
        
        var lo1 = false
        let lon1 = self.longitude1.text
        
            if lon1 != ""
            {
                lo1 = true
            }
        
        
        var lo2 = false
        let lon2 = self.longitude2.text
        
            if lon2 != ""
            {
                lo2 = true
            }
        
        
        if(lt1 && lt2 && lo1 && lo2)
        {
            let t1 = Double(lat1!)
            let t2 = Double(lat2!)
            let g1 = Double(lon1!)
            let g2 = Double(lon2!)
            
            let distanceString = calculateDistance(latitude1: t1!, latitude2: t2!, longitude1: g1!, longitude2: g2!)
            
            let bearingString = calculateBearing(latitude1: t1!, latitude2: t2!, longitude1: g1!, longitude2: g2!)
            
            distanceField.text = distanceString
            bearingField.text = bearingString
            
            
        }
        else
        {
            print("Please enter valid values for all fields")
        }
        
    }
    
    func calculateDistance(latitude1:Double, latitude2:Double, longitude1:Double, longitude2:Double) -> String
    {
        let radius: Double = 3959.0
        
        let deltaP = (degreesToRadians(degree: latitude2)-degreesToRadians(degree: latitude1))
        let deltaL = (degreesToRadians(degree: longitude2)-degreesToRadians(degree: longitude1))
        
        let a = sin(deltaP/2)*sin(deltaP/2) + cos(degreesToRadians(degree: latitude1))*cos(degreesToRadians(degree: latitude2))*sin(deltaL/2)*sin(deltaL/2)
        let c = 2*atan2(sqrt(a), sqrt(1-a))
        
        var d = radius * c
        
        if(distUnits == "Kilometers")
        {
            d = d*1.60934
        }
        
        let finalD = roundTo(num: d, places: 2)
        
        let dString = String(finalD) + " " + distUnits
        
        return dString
    }
    
    func calculateBearing(latitude1:Double, latitude2:Double, longitude1:Double, longitude2:Double) -> String
    {
        let y = sin(longitude2-longitude1) * cos(latitude2)
        let x = cos(latitude1) * sin(latitude2)-sin(latitude1)*cos(latitude2)*cos(longitude2-longitude1)
        
        var bearing = radiansToDegrees(radian: atan2(y, x))
        
        bearing = (bearing + 360.0).truncatingRemainder(dividingBy: 360.0)
        
        if(bearUnits == "Mils")
        {
            bearing = bearing*17.777778
        }
        
        let finalB = roundTo(num: bearing, places: 2)
        
        let bearingString = String(finalB) + " " + bearUnits
        
        return bearingString
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        latitude1.text = ""
        latitude2.text = ""
        longitude1.text = ""
        longitude2.text = ""
        
        distanceField.text = ""
        bearingField.text = ""
    }
    
    @IBOutlet weak var distanceField: UILabel!
    
    @IBOutlet weak var bearingField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        self.view.addGestureRecognizer(detectTouch)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func degreesToRadians(degree:Double)-> Double
    {
        return degree*3.14/180
    }
    
    func radiansToDegrees(radian:Double) -> Double
    {
        return radian*180/3.14
    }
    
    func roundTo(num:Double, places:Int) -> Double
    {
        let divisor = pow(10.0, Double(places))
        return (num*divisor).rounded()/divisor
    }

    @objc func dismissKeyboard()
    {
        self.view.endEditing(true)
        
    }
    
    func recalculate()
    {
        calculatePressed(self)
    }
}


