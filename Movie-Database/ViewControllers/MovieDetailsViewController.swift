//
//  MovieDetailsViewController.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 18/07/22.
//

import Kingfisher
import UIKit
import Combine
import Resolver

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var synopsisHeight: NSLayoutConstraint!
    @IBOutlet weak var synopsisButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genres: UILabel!
    var initialHeightSize: CGFloat = CGFloat()
    
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
    
    var viewModel: DetailsViewModel = Resolver.resolve()
    
    var cast: [Actor] = []
    var images: [Image] = []
    
    var subscribers = Set<AnyCancellable>()
    
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
        observerViewModel()
        viewModel.start()
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CastSegue" {
            guard let castAndCrewTableViewController = segue.destination.children.first as? CastTableViewController else { return }
            castAndCrewTableViewController.cast = cast
        }
        
        if segue.identifier == "ImagesSegue" {
            guard let photosTableViewController = segue.destination.children.first as? PhotosTableViewController else { return }
            
            photosTableViewController.images = images
        }
    }
    
    func observerViewModel() {
        viewModel.$photos.getOutput(store: &subscribers) { [weak self] photos in
            if let self = self {
                self.images = photos
                self.configureDataSource()
                self.photos.collectionViewLayout = self.configureLayout()
            }
        }
        
        viewModel.$castAndCrew.getOutput(store: &subscribers) { [weak self] castAndCrew in
            if let self = self {
                self.cast = castAndCrew
                guard let castAndCrewTableViewController = self.children.first as? CastTableViewController else { return }
                castAndCrewTableViewController.cast = self.cast
                castAndCrewTableViewController.tableView.reloadData()
            }
        }
    }

    
    func updateData() {
        self.genres.text = viewModel.getGenreText()
        self.synopsis.text = viewModel.getOverview()
        self.titleLabel.text = viewModel.getTitle()
        self.imageView.kf.setImage(with: viewModel.getImageURL())
        self.rating.text = "\(viewModel.movie?.voteAverage ?? 0.0)"
        self.runtime.text = viewModel.movie?.runtime
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
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: self.photos, cellProvider: { collectionView, indexPath, imagePath in
            guard let cell = self.photos.dequeueReusableCell(withReuseIdentifier: "PhotoCellCollectionView", for: indexPath) as? PhotoCellCollectionView else { fatalError("Cannot create a cell")}
            
            cell.imageView.kf.setImage(with: URL(string: API.imagesURL + imagePath))
            
            return cell
        })
        
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(images.map({ image in
            image.filePath
        }))
        
        dataSource.apply(initialSnapshot)
    }
}




