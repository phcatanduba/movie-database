//
//  MovieDetailsViewController.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 18/07/22.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
   
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: 0, height: 900)
    }
    
    override func viewDidLoad() {
    
    }
}
