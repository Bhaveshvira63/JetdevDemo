//
//  ApiRequest.swift
//  JetDemo
//
//  Created by Virani Bhavesh Madhavajibhai on 10/12/22.
//

import Foundation
import Alamofire
import RxSwift

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

class ApiRequest<ResponseType: Codable> {

    func webserviceUrl() -> String {
        return "https://jetdevs.mocklab.io/"
        
    }

    func apiPath() -> String {
        return ""
    }

    func apiVersion() -> String {
        return ""
    }

    func apiResource() -> String {
        return ""
    }

    func endPoint() -> String {
        return ""
    }

    func bodyParams() -> NSDictionary? {
        return [:]
    }

    func requestType() -> HTTPMethod {
        return .post
    }

    func contentType() -> String {
        return "application/json"
    }
}
