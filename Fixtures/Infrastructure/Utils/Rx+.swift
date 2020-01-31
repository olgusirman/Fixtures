//
//  Rx+.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    
    func ignoreAll() -> Observable<Void> {
        return map { _ in }
    }
    
    func unwrap<T>() -> Observable<T> where Element == Optional<T> {
        return filter { $0 != nil }.map { $0! } //self.compactMap({ $0 }) will also works
    }

    func flatMapIgnore<O: ObservableConvertibleType>(_ selector: @escaping (Element) throws -> O) -> Observable<Element> {
        return flatMap { result -> Observable<Element> in
            let ignoredObservable = try selector(result)

            return ignoredObservable.asObservable()
                .flatMap { _ in Observable.just(result) }
                .take(1)
        }
    }

    func count() -> Observable<(Element, Int)>{
        var numberOfTimesCalled = 0
        let result = map { _ -> Int in
            numberOfTimesCalled += 1
            return numberOfTimesCalled
        }

        return Observable.combineLatest(self, result)
    }

    func merge(with other: Observable<Element>) -> Observable<Element> {
        return Observable.merge(self.asObservable(), other)
    }
    
}
extension Observable where Element == String {

    func mapToURL() -> Observable<URL> {
        return map { URL(string: $0) }
            .filter { $0 != nil }
            .map { $0! }
    }
}

extension Driver where Element == String {
    
    func mapToURL() -> Driver<URL> {
        return map { URL(string: $0) }
            .filter { $0 != nil }
            .map { $0! }
            .asDriver(onErrorJustReturn: URL(string: "https://via.placeholder.com/200/D7C6A9/FFFFFF/?text=Fixtures%20%20")!)
    }
    
}

extension Observable where Element == Data {
    func map<D: Decodable>( _ type: D.Type) -> Observable<D>  {
        return map { try JSONDecoder().decode(type, from: $0) }
    }
}

extension Observable where Element == Bool {
    
    func negate() -> Observable<Bool> {
        return map { !$0 }
    }

}

extension Observable where Element: Sequence, Element.Iterator.Element: Comparable {
    
    /**
     Transforms an observable of sequences into an observable of ordered arrays by using the sequence element's
     natural comparator.
     */
    
    func sorted<T>() -> Observable<[T]> where Element.Iterator.Element == T {
        return map { $0.sorted() }
    }
    
    func sorted<T>(_ areInIncreasingOrder: @escaping (T, T) -> Bool) -> Observable<[T]>
        where Element.Iterator.Element == T {
            return map { $0.sorted(by: areInIncreasingOrder) }
    }
}


extension ObservableType where Element: Collection {

    func mapMany<T>(_ transform: @escaping (Self.Element.Element) -> T) -> Observable<[T]> {
        return self.map { collection -> [T] in
            collection.map(transform)
        }
    }
}
