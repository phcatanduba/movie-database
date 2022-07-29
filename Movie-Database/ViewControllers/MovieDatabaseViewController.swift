//
//  ViewController.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 12/07/22.
//

import UIKit

class MovieDatabaseViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl! {
        didSet {
            configureSegmentedControl()
        }
    }
    
    @IBOutlet weak var movies: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movies.collectionViewLayout = configureLayout()
        GenresStore()
        configureDataSource()
        NotificationCenter.default.addObserver(self, selector: #selector(configureDataSource), name: NSNotification.Name("NowPlayingReceived"), object: nil)
    }
    
    var moviesList: [Movie] {
        MoviesStore.movies
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let widthDimension: NSCollectionLayoutDimension = .fractionalWidth(0.47)
        let heightDimension: NSCollectionLayoutDimension = .fractionalHeight(1.0)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: heightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(0), top: .fixed(0), trailing: .flexible(0), bottom: .fixed(0))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(310))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    @objc func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: self.movies) { collectionView, indexPath, movie -> UICollectionViewCell? in
            guard let cell = self.movies.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
                fatalError("Cannot create new cell")
            }
            cell.image.image =  ImagesStore.images[movie.posterPath]?.uiImage
            cell.title.text = movie.title
            cell.info.text = "\(movie.genres[0].name) * \(movie.releaseDate.formatted(date: .numeric, time: .omitted)) | \(movie.voteAverage)"
            return cell
        }

        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(moviesList)
        dataSource.apply(initialSnapshot)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        configureSegmentedControl()
    }
    
    func configureSegmentedControl() {
        let isLightMode = UITraitCollection.current.userInterfaceStyle == .light
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: isLightMode ? UIColor.black : UIColor.white], for: UIControl.State.normal)
    }
}

