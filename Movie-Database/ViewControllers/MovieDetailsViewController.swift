//
//  MovieDetailsViewController.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 18/07/22.
//

import Foundation
import Kingfisher
import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var synopsisHeight: NSLayoutConstraint!
    @IBOutlet weak var synopsisButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genres: UILabel!
    
    var initialHeightSize: CGFloat = CGFloat()
    var movie: Movie?
    
    @IBAction func changeSynopsisHeight(_ sender: Any) {
        if synopsis.isTruncated {
            synopsisButton.setTitle("Show Less", for: .normal)
            synopsisHeight.constant = synopsis.fullHeight
            scrollView.contentSize = CGSize(width: 0, height: initialHeightSize + synopsis.fullHeight - 100)
            synopsis.layoutIfNeeded()
            synopsisButton.layoutIfNeeded()
        } else {
            synopsisButton.setTitle("Show More", for: .normal)
            synopsisHeight.constant = 100
            scrollView.contentSize.height = initialHeightSize
            synopsis.layoutIfNeeded()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photos: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    enum Section {
        case main
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let views = scrollView.subviews.first else { return }
                
        initialHeightSize = CGFloat(views.subviews.reduce(into: .zero) { cgSize, view in
            cgSize += view.bounds.height
        })
        
        scrollView.contentSize.height = initialHeightSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        configureDataSource()
        photos.collectionViewLayout = configureLayout()
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    func updateData() {
        guard let movie = movie else {
            return
        }

        self.genres.text = movie.genres.map({ genre in
            genre.name
        }).joined(separator: ", ")
        self.synopsis.text = movie.overview
        self.titleLabel.text = movie.title
        self.imageView.kf.setImage(with: URL(string: ImagesStore.rootURL + movie.backdropPath))
        self.rating.text = "\(movie.voteAverage)"
    }
    
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let groupWidth = CGFloat(108 * dataSource.snapshot().numberOfItems)
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(108), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: self.photos, cellProvider: { collectionView, indexPath, imageName in
            guard let cell = self.photos.dequeueReusableCell(withReuseIdentifier: "PhotoCellCollectionView", for: indexPath) as? PhotoCellCollectionView else { fatalError("Cannot create a cell")}
            
            cell.imageView.image = UIImage(named: imageName)
            
            return cell
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(["collectionView", "collectionView2", "collectionView3", "collectionView4", "collectionView5", "collectionView6"])
        
        dataSource.apply(initialSnapshot)
    }
}
