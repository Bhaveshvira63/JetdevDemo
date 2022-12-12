//
//  LoginService.swift
//  JetDemo
//
//  Created by Virani Bhavesh Madhavajibhai on 10/12/22.
//

import Foundation
import RxSwift


class LoginService {

    func login(data:LoginModel) -> Observable<LoginResponse>  {
        let request = LoginRequest()
        request.email = data.email
        request.password = data.password
        return ApiManager().callApi(request: request)
    }

}
