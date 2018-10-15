//
//  Created by Judge Madan on 8/8/18.
//  Copyright © 2018 Judge Madan. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationDescription: UILabel!
    @IBOutlet weak var plantButton: UIButton!
    
    var index : Int!
    
    
    @IBAction func plantButtonPress(_ sender: UIButton) {
        
        
        
        let defaults = UserDefaults.standard
        
        if let storedPlants = defaults.array(forKey: "storedPlants") as? [Int] {
            if(storedPlants.contains(index)==false){
                defaults.set(storedPlants + [index], forKey: "storedPlants")
                plantButton.setTitle(" Remove Plant", for: .normal)
                plantButton.setImage(UIImage(named: "minus")!, for: .normal)
            }
            else{
                defaults.set(storedPlants.filter{$0 != index}, forKey: "storedPlants")
                plantButton.setTitle(" Add Plant", for: .normal)
                plantButton.setImage(UIImage(named: "plus")!, for: .normal)

            }
        }
        else{
            defaults.set([index], forKey: "storedPlants")
        }
        
     

    }
}
