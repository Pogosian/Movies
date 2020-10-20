//
//  MoviePresenter.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import Foundation

protocol MoviePresenterProtocol {
    init(view: MovieViewControllerProtocol, id: Int)
    func getMovie()
}

class MoviePresenter: MoviePresenterProtocol {
    
    private unowned let view: MovieViewControllerProtocol

    required init(view: MovieViewControllerProtocol, id: Int) {
        self.view = view
        self.id = id
    }
    
    let movieApi = MovieRequests()
    let id: Int
    
    func getMovie() {
        self.view.startActivityIdicator()
        movieApi.getMovie(id: id) { [weak self] (data, error) in
            guard let self = self else { return }
            
            self.view.stopActivityIdicator()
            if let error = error as? CustomError {
                self.view.showErrorAlert(message: error.localizedDescription)
                return
            }
            
            if let data = data as? MovieResponse {
                print(data)
                self.view.setupData(movie: data)
            }
        }
    }
    
}
