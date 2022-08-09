//
//  ViewController.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 12/07/22.
//

import UIKit
import Kingfisher
import Combine

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
    
    private let viewModel = MoviesViewModel()
    private var subscribers = Set<AnyCancellable>()
    
    var comingSoon: [Movie] = []
    var nowPlaying: [Movie] = []
    var moviesList: [Movie] {
        viewModel.isComingSoon ? comingSoon : nowPlaying
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movies.delegate = self
        movies.collectionViewLayout = configureLayout()
        configureDataSource()
        segmentedControl.addTarget(self, action: #selector(changeSegmentedControl), for: .valueChanged)
        observeViewModel()
    }
    
    @objc func changeSegmentedControl() {
        viewModel.isComingSoon.toggle()
        configureDataSource()
    }
    
    private func observeViewModel() {
        
        viewModel.$nowPlaying.getOutput(store: &subscribers) { [weak self] movies in
            self?.nowPlaying = movies
            self?.configureDataSource()
        }
        
        viewModel.$comingSoon.getOutput(store: &subscribers) { [weak self] movies in
            self?.comingSoon = movies
            self?.configureDataSource()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetails" {
            guard let destination = segue.destination as? MovieDetailsViewController, let movieCell = sender as? MovieCell, let movie = movieCell.movie else { return }
            
            let viewModel = DetailsViewModel(movie: movie)
            destination.viewModel = viewModel
        }
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
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: self.movies) { collectionView, indexPath, movie -> UICollectionViewCell? in
            guard let cell = self.movies.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
                fatalError("Cannot create new cell")
            }
            cell.movie = movie
            cell.image.kf.setImage(with: URL(string: API.imagesURL + movie.posterPath))
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

extension MovieDatabaseViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if scrollView.contentSize.height - 506 < scrollView.bounds.minY {
            viewModel.nextPage()
        }
    }
}

