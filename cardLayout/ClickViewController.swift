//
//  ClickViewController.swift
//  cardLayout
//
//  Created by Judge Madan on 8/8/18.
//

import UIKit


class ClickViewController: UIViewController {
    
    
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var descriptionText: UILabel!
    @IBOutlet var plantLabel: UILabel!
    @IBOutlet var difficultyLabel: UILabel!
    @IBOutlet var plantImage: UIImageView!
    @IBOutlet var scrollViewController: UIScrollView!
    
    var selectedIndex : Int!
    var selectedPlant : String!
    var selectedImage : UIImage!
    var selectedDifficulty: String!
    let descriptions = plantData.getDesc()
    let tips = plantData.getTips()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Plant Information"
        plantImage.image = selectedImage
        plantLabel.text = selectedPlant
        difficultyLabel.text = selectedDifficulty
        plantImage.layer.cornerRadius = 5
        
        descriptionText.lineBreakMode = .byWordWrapping
        descriptionText.numberOfLines = 0
        descriptionText.text = descriptions[selectedIndex]
        
        tipLabel.lineBreakMode = .byWordWrapping
        tipLabel.numberOfLines = 0
        tipLabel.text = tips[selectedIndex]
        
    }
    

}
