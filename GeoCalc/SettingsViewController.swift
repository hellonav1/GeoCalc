//
//  SettingsViewController.swift
//  GeoCalc
//
//  Created by Nav Dalmia on 5/26/18.
//  Copyright © 2018 Nav Dalmia. All rights reserved.
//

import UIKit

protocol SettingsSelectionViewControllerDelegate
{
    func indicateDistanceSelection(dist:String)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var distancePicker: UIPickerView!
    var distanceData : [String] = [String]()
    var dSelection : String = " miles"
    var dDelegate : SettingsSelectionViewControllerDelegate?
    
    @IBOutlet weak var distanceField: UILabel!
    
    @IBOutlet weak var bearingPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton =  true
        
        self.distanceData = [" miles", " kilometers"]
        self.distancePicker.delegate = self
        self.distancePicker.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    @IBAction func savePressed(_ sender: Any) {
       
        super.viewWillDisappear(true)
        if let d = self.dDelegate
        {
            d.indicateDistanceSelection(dist: dSelection)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return distanceData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.distanceData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        distanceField.text = self.distanceData[row]
        self.dSelection = self.distanceData[row]
    }
}

