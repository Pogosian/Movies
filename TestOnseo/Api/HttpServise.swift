//
//  AppDelegate.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import Foundation
import Alamofire

typealias responseBlock = (_ swiftObj: Any?, _ error: Error?) -> Void

enum QueueQos {
    case background
    case defaultQos
}

protocol CustomErrorProtocol: Error {
    var localizedDescription: String { get }
    var code: Int { get }
}

struct CustomError: CustomErrorProtocol {
    
    var localizedDescription: String
    var code: Int
    
    init(localizedDescription: String, code: Int) {
        self.localizedDescription = localizedDescription
        self.code = code
    }
}

class HttpService {
    
    func checkInternetConnect() -> Bool {
        return InternetService.shared.checkInternetConnect()
    }
    
    func internetConnectErr() -> CustomError {
        return CustomError(localizedDescription: "Houston we have a problem", code: 402)
    }
    
    func serverError() -> CustomError {
        return CustomError(localizedDescription: "Houston we have a problem", code: 500)
    }
    
    func serverSomthWrongError() -> CustomError {
        return CustomError(localizedDescription: "Houston we have a problem", code: 500)
    }
    
    func requestError(_ description: String?, _ error: Int?) -> CustomError {
        return CustomError(localizedDescription: description ?? "Houston we have a problem", code: error ?? 404)
    }
    
}

extension HttpService {
    
    func cancellAllRequests() {
        
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
    
    func queryWithApiKey(_ url: URLConvertible,
                       method: HTTPMethod = .get,
                       parameters: Parameters? = nil,
                       encoding: ParameterEncoding = URLEncoding.queryString,
                       headers: HTTPHeaders? = nil,
                       queue: QueueQos,
                       resp: @escaping responseBlock) {
        var params: [String : Any] = [:]
        if let parameters = parameters {
            params = parameters
        }
        params[Requests.apiKeyTitle] = Requests.apiKeyValue
        query(url,
              method: method,
              parameters: params,
              encoding: encoding,
              headers: headers,
              queue: queue,
              resp: resp)
        
    }
    
    internal func query(_ url: URLConvertible,
                        method: HTTPMethod = .get,
                        parameters: Parameters? = nil,
                        encoding: ParameterEncoding = JSONEncoding.default,
                        headers: HTTPHeaders? = nil,
                        queue: QueueQos,
                        resp: @escaping responseBlock) {
        
        var queueQos = DispatchQueue(label: "queueBackground", qos: .background, attributes: [.concurrent])
        
        switch queue {
        case QueueQos.defaultQos:
            queueQos = DispatchQueue(label: "queueDefault", qos: .default, attributes: [.concurrent])
        default:
            break
        }
        
        if !checkInternetConnect() {
            return resp(nil, internetConnectErr())
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        let request = AF.request(url,
                                 method: method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: headers
        ).responseJSON (queue: queueQos) { (response) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            var statusCode: Int = 0
            
            if let code = response.response?.statusCode {
                statusCode = code
                print(statusCode)
            }
            
            switch response.result {
            case .success(let value):
                
                guard let jsonResp = try? JSONSerialization.data(withJSONObject: value, options: []), let jResp = (try? JSONSerialization.jsonObject(with: jsonResp)) else { return }
                
                if let dict = jResp as? [String: Any] {
                    
                    print(dict)
                    
                    if let errorMessage = dict["message"] as? String {
                        let customError = CustomError(localizedDescription: errorMessage, code: statusCode)
                        return resp(nil, customError)
                    }
                }
                
                resp(jsonResp, nil)
            case .failure:
                if (response.error as NSError?)?.code == NSURLErrorCancelled {
                    print("request canceled")
                } else {
                    resp(nil, self.serverError())
                }
            }
        }
        
        print("Request================")
        print (request)
    }
    
}
