//
//  LgoinRespository.swift
//  JetDemo
//
//  Created by Virani Bhavesh Madhavajibhai on 10/12/22.
//

import Foundation
import RxSwift

protocol LoginRepository {
    func login(data: LoginModel) -> Observable<LoginResponse>
}

struct LoginDataRepository: LoginRepository {
    func login(data: LoginModel) -> Observable<LoginResponse> {
         return LoginService().login(data: data)
    }
}

