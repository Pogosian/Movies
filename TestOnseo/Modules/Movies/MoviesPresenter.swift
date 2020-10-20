//
//  MoviesPresenter.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import UIKit

protocol MoviesPresenterProtocol {
    init(view: MoviesViewControllerProtocol)
    func getCountItem() -> Int
    func configurateCell(_ cell: MovieTableViewCellProtocol, item: Int)
    func heightForFooter() -> CGFloat
    func heightForCell() -> CGFloat
    func scrolingToItem(_ item: Int)
    func pressCell(_ item: Int)
}

class MoviesPresenter: MoviesPresenterProtocol {
    
    private unowned let view: MoviesViewControllerProtocol

    required init(view: MoviesViewControllerProtocol) {
        self.view = view
        getMovies()
    }
    
    var movies = [Movie]()
    let movieApi = MovieRequests()
    var page = 1
    var totalPage = 1
    
    private func getMovies() {
        self.view.startActivityIdicator()
        movieApi.getMovies(page: page) { [weak self] (data, error) in
            guard let self = self else { return }
            
            self.view.stopActivityIdicator()
            if let error = error as? CustomError {
                self.view.showErrorAlert(message: error.localizedDescription)
                return
            }
            
            if let data = data as? MoviesResponse {
                self.totalPage = data.totalPages
                self.movies += data.movies
                print(data.page)
                print(data.movies.count)
                self.view.reloadTable()
            }
        }
    }
    
    func pressCell(_ item: Int) {
        let vc = MovieViewController.instance(.home)
        vc.presenter = MoviePresenter(view: vc, id: movies[item].id)
        self.view.pushToVC(vc)
    }
    
    func scrolingToItem(_ item: Int) {
        if item != 0 && item.isMultiple(of: 19 * page) && page < totalPage {
            page += 1
            getMovies()
        }
    }
    
    func getCountItem() -> Int {
        return movies.count
    }
    
    func configurateCell(_ cell: MovieTableViewCellProtocol, item: Int) {
        cell.display(title: movies[item].title)
        cell.display(date: movies[item].releaseDate)
        cell.display(rating: String(movies[item].voteAverage))
        cell.display(description: movies[item].overview)
        let urlPoster = Requests.imagePath + movies[item].posterPath
        cell.display(posterImageUrl: urlPoster)
    }
    
    func heightForFooter() -> CGFloat {
        return 20
    }
    
    func heightForCell() -> CGFloat {
        return 100
    }
    
}
