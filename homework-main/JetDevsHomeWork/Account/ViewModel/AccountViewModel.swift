//
//  MyProfileViewModel.swift
//  JetDemo
//
//  Created by Virani Bhavesh Madhavajibhai on 12/12/22.
//

import Foundation
import RxSwift

protocol AccountViewModelProtocol {
    var setData: PublishSubject<(User?)> { get }
    func getData()
    func getCreatedDateStyle(createdAt: String) -> String
}

class AccountViewModel: AccountViewModelProtocol {
    var setData = PublishSubject<User?>()
    
    init() {}
    
    func getData(){
        let user =  UserDefaults.standard.value(forKey: "profile_data")
        if let user = user {
            if let userObj = try? JSONDecoder().decode(User.self, from: user as? Data ?? Data()) {
                setData.onNext(userObj)
            }
        }
    }
    func getCreatedDateStyle(createdAt: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let str = dateFormatterGet.date(from: createdAt)
        return "Created \(Date.now.dateDisplay(from: str ?? .now)) ago"
    }
}



