//
//  SentVC.swift
//  memeMe
//
//  Created by Tiago henrique on 1/31/17.
//  Copyright © 2017 Tiago henrique. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeListCell", for: indexPath) as! MemeListCell
        let meme =  appDelegate.memes[indexPath.row]
        cell.memeImage.image = meme.memed
        cell.memeText.text = "\(meme.textTop!)...\(meme.textBottom!)"
        return cell
    }

}
