//
//  Login.swift
//  MVVM_Pattern
//
//  Created by 이명직 on 2021/03/07.
//

import Foundation

struct User: Codable {
    let name: String
}

enum LoginError: Error {
    case defaultError
    case error(code: Int)
    
    var msg: String {
        switch  self  {
        case .defaultError:
            return "ERROR"
        case .error(let code):
            return "\(code) Error"
        }
    }
}

struct LoginModel {
    
    func requestLogin(id: String, pw: String) -> Observable<Result<User, LoginError>> {
        
        return Observable.create { (observer) -> Disposable in
            
            if id != "" && pw != "" {
                observer.onNext(.success(User(name: id)))
            } else {
                observer.onNext(.failure(.defaultError))
            }
            
            observer.onCompleted()
            
            return Disposables.create()
            
        }
        
    }
}

struct LoginViewModel {
        
    let idTfChanged = PublishRelay<String>()
    let pwTfChanged = PublishRelay<String>()
    let loginBtnTouched = PublishRelay<Void>()
    
    let result: Signal<Result<User, LoginError>>
        
    init(model: LoginModel = LoginModel()) {
        
        result = loginBtnTouched
            .withLatestFrom(Observable.combineLatest(idTfChanged, pwTfChanged))
            .flatMapLatest { model.requestLogin(id: $0.0, pw: $0.1)}
            .asSignal(onErrorJustReturn: .failure(.defaultError))
        
    }
    
}
