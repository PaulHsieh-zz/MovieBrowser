//
//  NetworkManager.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/13.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import Foundation
import Alamofire

struct APIResponseModel {
    var response: [String:AnyObject]?
    var success: Bool
    var errorMessage: String?
    var error: Error?
}

class NetworkManager {
    static let sharedManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 300
        configuration.timeoutIntervalForResource = 300
        
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    
    // MARK: - GET class
    class Get {
        public enum GetName:String {
            case list
        }
        
        private static func urlParser(name:GetName, path:String?) -> String {
            var apiPath = ""
            switch name {
            case .list:
                apiPath = "discover/movie"
            }
            
            return Constant.apiBaseUrl + apiPath
        }
        
        static func request(Name name:GetName, Parameter parameter:[String:AnyObject]?, Path path:String?, completionHandler: @escaping (APIResponseModel) -> ()) {
            let apiUrl = urlParser(name: name, path: path)
            let url = apiUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
            sharedManager.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil).validate().responseJSON {
                response in switch response.result {
                case .success(let json):
                    guard let responseJson = json as? [String:AnyObject] else {
                        completionHandler(APIResponseModel(response: nil,
                                                           success: false,
                                                           errorMessage: "CANNOT_CONVERT_TO_JSON",
                                                           error: nil))
                        return
                    }
                    
                    if let statusCode = response.response?.statusCode {
                        if case 200..<300 = statusCode {
                            completionHandler(APIResponseModel(response: responseJson,
                                                               success: true,
                                                               errorMessage: nil,
                                                               error: nil))
                        }
                        else {
                            completionHandler(APIResponseModel(response: nil,
                                                               success: false,
                                                               errorMessage: "COMMON_NETWORK_ERROR",
                                                               error: nil))
                        }
                    }
                    else {
                        completionHandler(APIResponseModel(response: nil,
                                                           success: false,
                                                           errorMessage: "COMMON_NETWORK_ERROR",
                                                           error: nil))
                    }
                    
                    
                case .failure(let error):
                    completionHandler(APIResponseModel(response: nil,
                                                       success: false,
                                                       errorMessage: "COMMON_NETWORK_ERROR",
                                                       error: error as Error))
                    
                } // end of response switch
                
            } // end of request
            
        }
        
    }
    
    // ----- end of Get class ----- //
    
}

