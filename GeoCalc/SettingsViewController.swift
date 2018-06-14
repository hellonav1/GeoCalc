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
    func indicateSelection(dist:String, bear:String)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    var data : [String] = [String]()
    var dSelection : String = ""
    var bSelection : String = ""
    var delegate : SettingsSelectionViewControllerDelegate?
    
    var orientation : String = ""
    
    
    
    @IBOutlet weak var distanceField: UILabel!
    
    @IBOutlet weak var bearingField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton =  true
        picker.isHidden = true
        
        let tapDistance = UITapGestureRecognizer(target: self, action: #selector(self.distanceTapped))
        self.distanceField.addGestureRecognizer(tapDistance)
        
        let tapBearing = UITapGestureRecognizer(target: self, action: #selector(self.bearingTapped))
        self.bearingField.addGestureRecognizer(tapBearing)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hidePicker))
        self.view.addGestureRecognizer(tap)
        
        
        self.picker.delegate = self
        self.picker.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    @IBAction func savePressed(_ sender: Any) {
       
        super.viewWillDisappear(true)
        if let d = self.delegate
        {
            d.indicateSelection(dist: dSelection, bear:bSelection)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func getOrientation() -> String
    {
        return orientation
    }
    
    @objc func distanceTapped(sender: UITapGestureRecognizer)
    {
        print("gesture recognizer tapped")
        self.data = ["Miles","Kilometers"]
        self.picker.reloadAllComponents()
        self.picker.isHidden = false
        self.orientation = "distance"
        
        
    }
    
    @objc func bearingTapped(sender: UITapGestureRecognizer)
    {
        print("gesture recognizer tapped")
        self.picker.isHidden = false
        self.data = ["Degrees", "Mils"]
        self.picker.reloadAllComponents()
        self.picker.isHidden = false
        self.orientation = "bearing"
        
        
        
    }
    
    @objc func hidePicker(sender: UITapGestureRecognizer)
    {
        self.picker.isHidden = true
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
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let orientation = getOrientation()
        
        if(orientation == "distance")
        {
            distanceField.text = self.data[row]
            self.dSelection = self.data[row]
        }
        
        else if(orientation == "bearing")
        {
            bearingField.text = self.data[row]
            self.bSelection = self.data[row]
            
        }
    }
}

