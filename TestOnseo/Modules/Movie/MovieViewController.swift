//
//  MovieViewController.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import UIKit

protocol MovieViewControllerProtocol: BaseViewControllerProtocol {
    func startActivityIdicator()
    func stopActivityIdicator()
    func setupData(movie: MovieResponse)
}

class MovieViewController: UIViewController {
        
    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originNameLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var countriesLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    var presenter: MoviePresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        presenter.getMovie()
    }
    
    // MARK: - UI
    
    private func setupViews() {
        activityIndicator.center = self.view.center
        containerView.isHidden = true
        setupNavBar()
    }
    
    private func setupNavBar() {
        self.title = "Movie"
    }
    
    // MARK: - IBActions
    
}

extension MovieViewController: MovieViewControllerProtocol {
    
    func startActivityIdicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIdicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func setupData(movie: MovieResponse) {
        DispatchQueue.main.async {
            if let imageUrl = URL(string: Requests.imagePath + movie.posterPath) {
                self.posterImage.sd_setImage(with: imageUrl, completed: nil)
            }
            self.nameLabel.text = "Name: " + movie.title
            self.originNameLabel.text = "Original name: " + movie.originalTitle
            let genres = movie.genres.compactMap{ $0.name }
            self.genresLabel.text = "Genres: " + genres.joined(separator: ", ")
            self.dateLabel.text = "Release date: " + movie.releaseDate
            self.ratingLabel.text = "Rating: \(movie.voteAverage), respondents: \(movie.voteCount)"
            let countris = movie.productionCountries.compactMap{ $0.name }
            self.countriesLabel.text = "Countris: " + countris.joined(separator: ", ")
            self.statusLabel.text = "Status: " + movie.status
            self.descriptionTextView.text = "Description: \(movie.overview)\nHomepage: \(movie.homepage)"
            self.containerView.isHidden = false
        }
    }
}
