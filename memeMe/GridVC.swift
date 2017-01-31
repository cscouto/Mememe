//
//  GridVC.swift
//  memeMe
//
//  Created by Tiago henrique on 1/31/17.
//  Copyright © 2017 Tiago henrique. All rights reserved.
//

import UIKit

class GridVC: UICollectionViewController {

    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }

}
