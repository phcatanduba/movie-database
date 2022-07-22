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
    
    @IBOutlet weak var castTableView: UITableView!
    @IBOutlet weak var photosTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: 0, height: 90000)
    }
    
    override func viewDidLoad() {

    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("OKOK")
    }
}
