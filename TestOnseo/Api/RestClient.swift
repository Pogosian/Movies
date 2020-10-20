//
//  RestClient.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import Foundation
import Alamofire

class RestClient: NSObject {
    
    internal var http = HttpService()
    internal let baseUrl = Requests.baseURL
    
    let dataIsNil = CustomError.init(localizedDescription: "Houston we have a problem", code: 0)
    
    func response<T: Codable>(_ response: Any?, _ error: Error?, modelCls: T.Type, key: String? = nil, resp: @escaping responseBlock) {
        
        if let err = error {
            return resp(nil, err)
        }
        
        guard let data = response as? Data else {
            return resp(nil, error)
            
        }
        do {
            let model = try JSONDecoder().decode(modelCls.self, from: data)
            return resp(model, nil)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            return resp(nil, self.dataIsNil)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return resp(nil, self.dataIsNil)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return resp(nil, self.dataIsNil)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return resp(nil, self.dataIsNil)
        } catch {
            print("error: ", error)
            return resp(nil, self.dataIsNil)
        }
    }
    
    func cancellRequests() {
        http.cancellAllRequests()
    }
}
