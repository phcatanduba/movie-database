//
//  CastTableViewController.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 19/07/22.
//

import UIKit
import Kingfisher

class CastTableViewController: UITableViewController {
    var cast: [Actor] = []
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell", for: indexPath) as? CastCell else { fatalError("Cannot create a cell") }
        let actor = cast[indexPath.row]
        
        cell.imageCell.kf.setImage(with: URL(string: ImagesStore.rootURL + (actor.profilePath ?? "")))
        cell.imageCell.layer.cornerRadius = 25
        cell.characterName.text = actor.character
        cell.actorName.text = actor.name
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cast.count
    }
}
