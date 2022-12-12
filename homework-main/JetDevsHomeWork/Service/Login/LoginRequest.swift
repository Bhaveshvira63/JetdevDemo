//
//  APIRequest.swift
//  JetDemo
//
//  Created by Virani Bhavesh Madhavajibhai on 10/12/22.
//

import RxSwift

class LoginRequest: ApiRequest<LoginResponse> {

    var email: String!
    var password: String!

    override func apiResource() -> String {
        return "login"
    }

    override func endPoint() -> String {
        return ""
    }

    override func bodyParams() -> NSDictionary? {
        return ["email": email ?? "",
                "password": password ?? ""]
    }

    override func requestType() -> HTTPMethod {
        return .post
    }

}
