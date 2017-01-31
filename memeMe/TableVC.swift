//
//  SentVC.swift
//  memeMe
//
//  Created by Tiago henrique on 1/31/17.
//  Copyright © 2017 Tiago henrique. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {
    
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeListCell", for: indexPath) as! MemeListCell
        let meme =  self.memes[indexPath.row]
        cell.memeImage.image = meme.originalImage
        cell.memeText.text = "\(meme.textTop)...\(meme.textBottom)"
        return cell
    }

}
