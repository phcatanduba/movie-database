//
//  CastTableViewController.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 19/07/22.
//

import UIKit

class CastTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell", for: indexPath) as? CastCell else { fatalError("Cannot create a cell") }
        
        cell.imageCell.image = UIImage(named: "Keanu Reeves")
        cell.imageCell.layer.cornerRadius = 25
        cell.characterName.text = "John WickWickWickWickWickWickWickWickWickWickWickWickWickWickWickWick"
        cell.actorName.text = "Keanu ReevesReevesReevesReevesReevesReevesReevesReevesReevesReevesReeves"
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12
    }
}
