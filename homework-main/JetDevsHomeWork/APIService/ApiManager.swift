//
//  ApiManager.swift
//  JetDemo
//
//  Created by Virani Bhavesh Madhavajibhai on 10/12/22.
//

import Foundation
import RxSwift

protocol DataManager {
    
}

class ApiManager {

    func callApi<ResponseType>(request: ApiRequest<ResponseType>) -> Observable<ResponseType> {
        return Observable.create { observer -> Disposable in
            
            let urlRequest = self.urlRequestWith(apiRequest: request)

            let task = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
        
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return
                }
                do {
                    let albums = try JSONDecoder().decode(ResponseType.self, from: data)
                    observer.onNext(albums)
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }

    private func urlRequestWith<ResponseType>(apiRequest: ApiRequest<ResponseType>) -> URLRequest {
        let  completeUrl = apiRequest.webserviceUrl() + apiRequest.apiPath() +
            apiRequest.apiVersion() + apiRequest.apiResource() + apiRequest.endPoint()
        var urlRequest = URLRequest(url: URL(string: completeUrl)!)
        urlRequest.httpMethod = apiRequest.requestType().rawValue
        urlRequest.setValue(apiRequest.contentType(), forHTTPHeaderField:  "Content-Type")
        urlRequest.httpBody = try?JSONSerialization.data(withJSONObject:  apiRequest.bodyParams()!, options: [])
        return urlRequest
    }
}
