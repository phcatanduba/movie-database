//
//  PhotosTableViewController.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 19/07/22.
//

import UIKit

class PhotosTableViewController: UITableViewController {
    
    var images: [Image] = []
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { fatalError("Cannot create a cell") }
        
        let path = images[indexPath.row].filePath
        
        cell.imageCell?.kf.setImage(with: URL(string: ImagesStore.rootURL + path))

        cell.backgroundColor = .clear
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
}
