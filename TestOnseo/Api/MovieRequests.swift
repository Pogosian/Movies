//
//  MovieRequests.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import Foundation
import Alamofire

class MovieRequests: RestClient {
    
    func getMovies(page: Int, resp: @escaping responseBlock) {
        let url = baseUrl + Requests.movie + Requests.topRated
        let params: [String : Any] = ["page" : page]
        http.queryWithApiKey(url, method: .get, parameters: params, queue: .defaultQos) { (data, error) in
            self.response(data, error, modelCls: MoviesResponse.self, resp: resp)
        }
    }
    
    func getMovie(id: Int, resp: @escaping responseBlock) {
        let url = baseUrl + Requests.movie + String(id)
        http.queryWithApiKey(url, queue: .defaultQos) { (data, error) in
            self.response(data, error, modelCls: MovieResponse.self, resp: resp)
        }
    }
}
