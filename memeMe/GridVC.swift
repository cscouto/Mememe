//
//  GridVC.swift
//  memeMe
//
//  Created by Tiago henrique on 1/31/17.
//  Copyright © 2017 Tiago henrique. All rights reserved.
//

import UIKit

class GridVC: UICollectionViewController{
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        collectionView?.reloadData()
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeGridCell", for: indexPath) as! MemeGridCell
        cell.memeImage.image = appDelegate.memes[indexPath.item].memed
        return cell
    }
}
