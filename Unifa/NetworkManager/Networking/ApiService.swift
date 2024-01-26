//
//  ApiService.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import Alamofire
import RxSwift

// MARK: - Api Service Protocol
protocol APIServiceProtocol {
    func request<Response>(
        _ endPoint: some APIRequestProtocol,
        decoder: JSONDecoder
    ) -> Observable<Response> where Response: Decodable
}

// MARK: - Api Service Class
class APIService: APIServiceProtocol {
    
    private let session: Session
    
    init(session: Session = Session()) {
        self.session = session
    }
    
    func request<Response>(
        _ endPoint: some APIRequestProtocol,
        decoder: JSONDecoder
    ) -> Observable<Response> where Response: Decodable {
        Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            guard let self else {
                observer.onError(APIError.unknown)
                observer.onCompleted()
                return disposables
            }
            self.session
                .request(endPoint)
                .validate()
                .responseDecodable(of: Response.self) { dataResponse in
                    switch dataResponse.result {
                    case .success(let decoded):
                        observer.onNext(decoded)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                        observer.onCompleted()
                    }
                }
            return disposables
        }
    }
}
