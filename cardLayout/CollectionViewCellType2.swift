//
//  CollectionViewCellType2.swift
//  cardLayout
//
//  Created by Judge Madan on 8/8/18.
//  Copyright © 2018 Judge Madan. All rights reserved.
//


import UIKit

class CollectionViewCellType2: UICollectionViewCell {
    
    @IBOutlet var Nickname: UIButton!
    @IBOutlet var plantName: UILabel!
    var alertController:UIAlertController?
    let defaults = UserDefaults.standard
    var plantID: Int!
    
    @IBAction func nicknamePressed(_ sender: UIButton) {

            var alertController:UIAlertController?
            alertController = UIAlertController(title: "Enter Nickname",
                                                message: nil,
                                                preferredStyle: .alert)
            
        alertController!.addTextField(
            configurationHandler: {(textField: UITextField!) in
                    textField.placeholder = "Text"
            })
            
            let action = UIAlertAction(title: "Submit",
                                       style: UIAlertActionStyle.default,
                                       handler: {[weak self]
                                        (paramAction:UIAlertAction!) in
                                        if let textFields = alertController?.textFields{
                                            let theTextFields = textFields as [UITextField]
                                            let enteredText = theTextFields[0].text
//                                           self!.displayLabel.text = enteredText
                                            self!.Nickname.setTitle(enteredText, for: .normal)
                                            
                                            if var storedNicknames = self!.defaults.array(forKey: "plantNick") as? [String] {
                                                storedNicknames[self!.plantID] = enteredText ?? "Tap to Edit Nickname"
                                                self!.defaults.set(storedNicknames, forKey: "plantNick")
                                            }
                                            else{
                                                self!.defaults.set([String](repeating: "Tap to Edit Nickname", count:10), forKey: "plantNick")
                                            }
                                        }
            })
        
        
            alertController?.addAction(action)
            self.window?.rootViewController?.present(alertController!, animated: true, completion:nil)
        
    }
}
