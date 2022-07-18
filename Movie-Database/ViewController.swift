//
//  ViewController.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 12/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movies: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    

    @IBOutlet weak var nowPlayingButton: UIButton!
    @IBOutlet weak var comingSoonButton: UIButton!
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movies.collectionViewLayout = configureLayout()
        configureDataSource()
        configureButtons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("OK!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let widthDimension: NSCollectionLayoutDimension
        let heightDimension: NSCollectionLayoutDimension
        
        if UIDevice.current.orientation.isLandscape {
            widthDimension = .fractionalHeight(1.0)
            heightDimension = .fractionalWidth(0.5)
        } else {
            widthDimension = .fractionalWidth(0.5)
            heightDimension = .fractionalHeight(1.0)
        }
        
        let itemSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: heightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: self.movies) { collectionView, indexPath, movie -> UICollectionViewCell? in
            guard let cell = self.movies.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
                fatalError("Cannot create new cell")
            }
            cell.image.image =  UIImage(named: movie.title)
            cell.title.text = movie.title
            cell.info.text = movie.originalTitle
            return cell
        }
        let romance = Genre(id: 1, name: "romance")
        let terror = Genre(id: 0, name: "terror")
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems([Movie(id: 1, voteAverage: 2, title: "Captain Marvel", originalTitle: "madagascar", popularity: 10, posterPath: "posterPath", backdropPath: "backdropPath", overview: "overview", releaseDate: "2000-07-18", genres: [terror, romance]), Movie(id: 2, voteAverage: 2, title: "Avengers", originalTitle: "madagascar", popularity: 10, posterPath: "posterPath", backdropPath: "backdropPath", overview: "overview", releaseDate: "2000-07-18", genres: [terror, romance]), Movie(id: 3, voteAverage: 2, title: "Avengers End Game", originalTitle: "madagascar", popularity: 10, posterPath: "posterPath", backdropPath: "backdropPath", overview: "overview", releaseDate: "2000-07-18", genres: [terror, romance])])
        dataSource.apply(initialSnapshot)
    }
    
    func configureButtons() {
        let comingSoonGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeFilter))
        let nowPlayingGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeFilter))
        comingSoonButton.addGestureRecognizer(comingSoonGestureRecognizer)
        nowPlayingButton.addGestureRecognizer(nowPlayingGestureRecognizer)
    }
    
    @objc func changeFilter() {
        let comingSoonConfiguration = comingSoonButton.configuration?.background
        comingSoonButton.configuration?.background = nowPlayingButton.configuration!.background
        nowPlayingButton.configuration?.background = comingSoonConfiguration!
        
    }
}

