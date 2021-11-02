//
//  do.swift
//  RHSwiftExtensions
//
//  Created by 荣恒 on 2019/4/4.
//

import Foundation
import RxSwift


// MARK: - do 副作用
public extension ObservableType {
 
    func `do`(next: @escaping () -> Void) -> Observable<Element> {
        return self.do(onNext: { _ in next() })
    }
    
    func `do`(next: @escaping (Element) -> Void) -> Observable<Element> {
        return self.do(onNext: { value in  next(value) })
    }
    
    /// 给Success添加副作用
    func `do`<T,E>(success: @escaping (T) -> Void) -> Observable<Element> where Self.Element == Result<T,E>, E : Error {
        return self.do(onNext: { result in
            switch result {
            case let .success(value): success(value)
            case .failure: break
            }
        })
    }
    
    /// 给Failure添加副作用
    func `do`<T,E>(failure: @escaping (E) -> Void) -> Observable<Element> where Self.Element == Result<T,E>, E : Error {
        return self.do(onNext: { result in
            switch result {
            case .success: break
            case let .failure(error): failure(error)
            }
        })
    }
    
}
