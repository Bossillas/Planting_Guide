//
//  Created by Judge Madan on 8/8/18.
//  Copyright © 2018 Judge Madan. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let plantNames = plantData.getNames()
    let defaults = UserDefaults.standard
    
    @IBOutlet var collectionView: UICollectionView!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Current Plants"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("accessed")
        if let storedPlants = defaults.array(forKey: "storedPlants") as? [Int] {
            return storedPlants.count
        }
        else{
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celltype2", for: indexPath) as! CollectionViewCellType2
        
        if var storedNicknames = self.defaults.array(forKey: "plantNick") as? [String] {
            cell.Nickname.setTitle(storedNicknames[indexPath.row], for: .normal)
        }

        if let storedPlants = defaults.array(forKey: "storedPlants") as? [Int] {
            cell.plantID = storedPlants[indexPath.row]
            cell.plantName.text = plantNames[cell.plantID]
        }
      

        
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
        let currentPlantController = self.storyboard?.instantiateViewController(withIdentifier: "ClickViewControllerType2") as! ClickViewControllerType2
        self.navigationController?.pushViewController(currentPlantController, animated: true)
       
        let plantIDs = plantData.getIDs()

        currentPlantController.plantID = plantIDs[indexPath.row]
        
//        currentPlantController.selectedImage = locationImages[indexPath.row]
//        plantViewController.selectedDifficulty = locationDescription[indexPath.row]
//        plantViewController.selectedIndex = indexPath.row


    }
    
    
    
}

