//
//  MovieCell.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 16/07/22.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: MovieCell.self)
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
    
    var movie: Movie?
}
