//
//  FixturesError.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum FixturesError: Int, Error {
    
    /// Generic
    case unknownError = 0
    case noResponse = 1
    case pushNotificationUserIdError = 2

    enum UserManagementServiceError: Error {
        case generic(with: String)
        case userNotFoundForThisGsm(with: String) // 400 407
    }
    
    enum PromoServiceError: Error {
        case generic(with: String)
    }
    
    // Service Errors
    case notFound = 400
    case unautenticated = 401
    case unauthorized = 403
    case serviceNotFound = 404
    case conflict = 409
    case unknown = 500
    case serviceUnavailable = 503
    
    // Locale errors
    case noUserFound = 701
    case facebookSignUpError = 702
    case facebookSignInError = 703
    
    /// Local
    /// Moya
    /// Indicates a response failed to map to an image.
    case imageMapping = 601
    
    /// Indicates a response failed to map to a JSON structure.
    case jsonMapping = 602
    
    /// Indicates a response failed to map to a String.
    case stringMapping = 603
    
    /// Indicates a response failed to map to a Decodable object.
    case objectMapping = 604
    
    /// Indicates that Encodable couldn't be encoded into Data
    case encodableMapping = 605
    
    /// Indicates a response failed with an invalid HTTP status code.
    case statusCode = 606
    
    /// Indicates a response failed due to an underlying `Error`.
    case underlying = 607
    
    /// Indicates that an `Endpoint` failed to map to a `URLRequest`.
    case requestMapping = 608
    
    /// Indicates that an `Endpoint` failed to encode the parameters for the `URLRequest`.
    case parameterEncoding = 609
    
    private var domain: String {
        return "com.fixtures"
    }
    
    init?(statusCode: Int) {
        
        switch statusCode {
        case FixturesError.notFound.rawValue: self = .notFound
        case FixturesError.unautenticated.rawValue: self = .unautenticated
        case FixturesError.unauthorized.rawValue: self = .unauthorized
        case FixturesError.serviceNotFound.rawValue: self = .serviceNotFound
        case FixturesError.conflict.rawValue: self = .conflict
        case FixturesError.unknown.rawValue: self = .unknown
        case FixturesError.serviceUnavailable.rawValue: self = .serviceUnavailable
            
        default:
            self = .unknownError
        }
    }
    
    init?(moyaError: MoyaError) {
        
        switch moyaError {
        case .imageMapping:
            self = .imageMapping
        case .jsonMapping:
            self = .jsonMapping
        case .statusCode:
            self = .statusCode
        case .stringMapping:
            self = .stringMapping
        case .objectMapping:
            self = .objectMapping
        case .encodableMapping:
            self = .encodableMapping
        case .underlying:
            self = .underlying
        case .requestMapping:
            self = .requestMapping
        case .parameterEncoding:
            self = .parameterEncoding
        }
        
    }
    
    var localizedDescription: String {
        switch self {
        case .unknownError:
            return "Unknown error occured"
        case .noResponse:
            return "There couldn't get any response"
        default:
            return "Unknown error occured"
        }
    }
    
    func getFoundationError( message: String? = nil, userInfo: [String:Any]? ) -> NSError {
        
        let errorDescription: String = message ?? localizedDescription
        
        var info: [String:Any] = [NSLocalizedDescriptionKey: errorDescription]
        
        if let userInfo = userInfo {
            info["details"] = userInfo
        }
        
        return NSError(domain: self.domain, code: self.rawValue, userInfo:info)
    }
    
    static func configureResponse(response: Response) throws {
        
        if let mappedErrorJson = ((try? response.mapJSON() as? [String:Any]) as [String : Any]??), let errorJson = mappedErrorJson {
            debugPrint("mappedErrorJson \(errorJson)")
            
            let tempCode: Int
            if let code = errorJson["Code"] as? String {
                tempCode = Int(code) ?? 400
            } else if let code = errorJson["Code"] as? Int {
                tempCode = code
            } else {
                tempCode = 400
            }
            
            let details = errorJson["Content"] as? [String: Any]
            let message = details?["Message"] as? String
            
            let errorDescription: String = message ?? "Some Error occured"
            var info: [String:Any] = [NSLocalizedDescriptionKey: errorDescription]
            if let userInfo = details {
                info["details"] = userInfo
            }
            
            throw NSError(domain: "com.fixtures", code: tempCode, userInfo: details)
        } else {
            throw FixturesError.unknownError
        }
        
    }
    
    static func configure(error: Error) throws {
        
        // Check the response first
        if let error = error as? MoyaError {
            
            guard let response = error.response else {
                
                // If no response throw noResponse error
                throw FixturesError.noResponse
            }
            
            // If its not service error then check the MoyaErrors
            if let FixturesError = FixturesError(statusCode: response.statusCode), response.statusCode > 399 {
                // Handle the service response
                
                if let mappedErrorJson = ((try? error.response?.mapJSON() as? [String:Any]) as [String : Any]??) {
                    
                    //let code = mappedErrorJson?["Code"] as? String
                    let details = mappedErrorJson?["Content"] as? [String: Any]
                    let message = details?["Message"] as? String
                    
                    throw FixturesError.getFoundationError(message: message, userInfo: details)
                }
                
            }
            
        } else if let error = error as? RxError {
            
            switch error {
            case .timeout: throw FixturesError.unknownError
            default: throw FixturesError.unknownError
            }
            
        } else if let error = error as? FixturesError {
            throw error
        } else {
            throw error
        }
    }
    
    static let retryHandler: (Observable<Error>) -> Observable<Int> = { e in
        return e.enumerated().flatMap { (attempt, error) -> Observable<Int> in
            let maxAttempts = 4
            if attempt >= maxAttempts - 1 {
                return Observable.error(error)
            }
            print("== retrying after \(attempt + 1) seconds ==")
            return Observable<Int>
                .timer(RxTimeInterval.seconds(attempt + 1), scheduler: MainScheduler.instance)
                .take(1)
        }
    }
    
    static var fixturesCatchErrorHandler: (_ error: Error) -> Observable<FixturesServiceResult> = { error in
        
        do {
            try FixturesError.configure(error: error)
        } catch let catchedError {
            
            let nserror = catchedError as NSError
            
            let result: FixturesServiceResult
            
            switch nserror.code {
            case 400: result = FixturesServiceResult.error(.generic(with:nserror.localizedDescription))
            default: result = FixturesServiceResult.error(.generic(with: nserror.localizedDescription))
            }
            
            return Observable.just(result)
        }
        
        let result = FixturesServiceResult.error(.generic(with: FixturesError.unknownError.localizedDescription))
        return Observable.just(result)
    }
    
    static var configureResponseErrorHandler: (_ response: Response) -> PrimitiveSequence<SingleTrait, Response> = { response in
        
        if let mappedErrorJson = ((try? response.mapJSON() as? [String:Any]) as [String : Any]??), let errorJson = mappedErrorJson {
            debugPrint("mappedErrorJson \(errorJson)")
            
            let tempCode: Int
            if let code = errorJson["Code"] as? String {
                tempCode = Int(code) ?? 200
            } else if let code = errorJson["Code"] as? Int {
                tempCode = code
            } else {
                tempCode = 200
            }
            
            if tempCode > 399 {
                let details = errorJson["Content"] as? [String: Any]
                let message = details?["Message"] as? String
                
                let errorDescription: String = message ?? "Some Error occured"
                var info: [String:Any] = [NSLocalizedDescriptionKey: errorDescription]
                
                let error = NSError(domain: "com.fixtures", code: tempCode, userInfo: info)
                
                return Single.error(error)
            }
            
        }
        
        return Observable.just(response).asSingle()
    }
    
}
