//
//  BadgeViewController.swift
//  POP!Corn
//
//  Created by Giuseppe Tansella and Luca Mastroianni on 02/07/2019.
//  Copyright © 2019 unicampania.it. All rights reserved.
//

import UIKit

class BadgeViewController: UIViewController {

    
    @IBOutlet var badgeImageDetail: UIImageView!
    @IBOutlet var badgeNameDetail: UILabel!
    @IBOutlet var badgeDescDetail: UITextView!
    
    var badge: Achievement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        badgeNameDetail.text = badge.name
        badgeDescDetail.text = badge.description
        badgeImageDetail.image = badge.image
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
