//
//  ClickViewControllerType2ViewController.swift
//  cardLayout
//
//  Created by Judge Madan on 12/8/18.
//

import UIKit
import Charts


class ClickViewControllerType2: UIViewController {
    
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var descriptionText: UILabel!
    @IBOutlet var plantLabel: UILabel!
    @IBOutlet var difficultyLabel: UILabel!
    @IBOutlet var plantImage: UIImageView!
    @IBOutlet var scrollViewController: UIScrollView!
    @IBOutlet var pieChart: PieChartView!
    @IBOutlet var timeLabel: UILabel!
    
    var plantID : Int!
    let defaults = UserDefaults.standard
    let plantNames = plantData.getNames()
    let difficulties = plantData.getDifficulty()
    let images = plantData.getImages()
    let descriptions = plantData.getDesc()
    let tips = plantData.getTips()
    
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    var iosDataEntry = PieChartDataEntry(value: 0)
    var macDataEntry = PieChartDataEntry(value: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Plant Information"
        
        // creating pie chart for watering
        pieChart.chartDescription?.text = ""
        
        
        // styling
        plantImage.image = images[plantID]
        plantLabel.text = plantNames[plantID]
        difficultyLabel.text = difficulties[plantID]
        plantImage.layer.cornerRadius = 5
        
        descriptionText.lineBreakMode = .byWordWrapping
        descriptionText.numberOfLines = 0
        descriptionText.text = descriptions[plantID]
        
        tipLabel.lineBreakMode = .byWordWrapping
        tipLabel.numberOfLines = 0
        tipLabel.text = tips[plantID]
        
        
        // display timeLabel and initialize chart data
        if var waterTimes = self.defaults.array(forKey: "waterTimes") as? [Int] {
            if var setTime = self.defaults.array(forKey: "Dates") as? [Date] {
                let diff = Int(Date().timeIntervalSince1970-setTime[plantID].timeIntervalSince1970)
//                let hours = diff / 3600
                let minutes = diff/60
                
                var difference = (waterTimes[plantID] * 60) - minutes
                if(difference<0){
                    difference = 0
                }
                
                print(difference)
                timeLabel.text = "Your plant needs to be watered in " + String(difference/60) + " hour(s)."
                
                iosDataEntry.value = Double(difference)
                iosDataEntry.label = "Time Remaining"
                if(waterTimes[plantID] == 0){
                    macDataEntry.value=10
                }
                else{
                    macDataEntry.value = Double((waterTimes[plantID] * 60) - difference)
                }
                macDataEntry.label = "Time Elapsed"
                numberOfDownloadsDataEntries = [iosDataEntry, macDataEntry]
                pieChart.legend.enabled = false
                updateChartData()
                
            }
        }
        else{
            iosDataEntry.value = 0
            iosDataEntry.label = "Time Remaining"
            macDataEntry.value = 10
            macDataEntry.label = "Time Elapsed"
            numberOfDownloadsDataEntries = [iosDataEntry, macDataEntry]
            pieChart.legend.enabled = false
            updateChartData()
        }
        
    }
    
    func updateChartData(){
        let chartDataSet = PieChartDataSet(values: numberOfDownloadsDataEntries, label: nil)
        chartDataSet.drawValuesEnabled = false
        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueTextColor(UIColor.black)
        
        let colors = [UIColor(named:"color1"), UIColor(named:"color2")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        pieChart.data = chartData
    }
    
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Enter Time in Hours",
                                            message: nil,
                                            preferredStyle: .alert)
        
        alertController!.addTextField(
            configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "24"
        })
        
        let action = UIAlertAction(title: "Submit",
                                   style: UIAlertActionStyle.default,
                                   handler: {[weak self]
                                    (paramAction:UIAlertAction!) in
                                    if let textFields = alertController?.textFields{
                                        let theTextFields = textFields as [UITextField]
                                        let enteredText = theTextFields[0].text ?? "0"
                                        self!.timeLabel.text = "Your plant needs to be watered in " + enteredText + " hour(s)."
                                        
                                        if var storedTimes = self!.defaults.array(forKey: "waterTimes") as? [Int] {
                                            storedTimes[self!.plantID] = Int(enteredText) ?? 0
                                            self!.defaults.set(storedTimes, forKey: "waterTimes")
                                        }
                                        else{
                                            self!.defaults.set([Int](repeating: 0, count:10), forKey: "waterTimes")
                                        }
                                        
                                        if var setTime = self!.defaults.array(forKey: "Dates") as? [Date] {
                                            setTime[self!.plantID] = Date()
                                            self!.defaults.set(setTime, forKey: "Dates")
                                        }
                                        else{
                                            self!.defaults.set([Date](repeating: Date(), count:10), forKey: "Dates")

                                        }
                                    
                                    }
        })
        
        
        alertController?.addAction(action)
        self.present(alertController!, animated: true, completion: nil)
        
    }
    

}
