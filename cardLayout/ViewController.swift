//
//  Created by Judge Madan on 8/8/18.
//  Copyright © 2018 Judge Madan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let locationNames = plantData.getNames()
    let locationImages = plantData.getImages()
    let locationDescription = plantData.getDifficulty()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Plant Directory"
        
    }

    
   
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.locationImage.image = locationImages[indexPath.row]
        cell.locationName.text = locationNames[indexPath.row]
        cell.locationDescription.text = locationDescription[indexPath.row]
        cell.index = indexPath.row
        
        let defaults = UserDefaults.standard
        
        //if stored list is initialized
        if let storedPlants = defaults.array(forKey: "storedPlants") as? [Int] {
            //if stored list contains the plant
            if(storedPlants.contains(cell.index)){
                cell.plantButton.setTitle(" Remove Plant", for: .normal)
                cell.plantButton.setImage(UIImage(named: "minus")!, for: .normal)
            }
            else{
                cell.plantButton.setTitle(" Add Plant", for: .normal)
                cell.plantButton.setImage(UIImage(named: "plus")!, for: .normal)
            }
        }
        
        
2
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let plantViewController = self.storyboard?.instantiateViewController(withIdentifier: "ClickViewController") as! ClickViewController
        self.navigationController?.pushViewController(plantViewController, animated: true)
        
        plantViewController.selectedPlant = locationNames[indexPath.row]
        plantViewController.selectedImage = locationImages[indexPath.row]
        plantViewController.selectedDifficulty = locationDescription[indexPath.row]
        plantViewController.selectedIndex = indexPath.row
        
        
    }
    
    
    

}

