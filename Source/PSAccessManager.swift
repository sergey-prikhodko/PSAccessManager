//
//  PSAccessManager.swift
//  PSAccessManager
//
//  Created by Sergey Prikhodko on 03.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation
import LocalAuthentication

public final class PSAccessManager {
        
    public var reason = ""
    public var localizedCancelTitle = "Cancel" { didSet { context.localizedCancelTitle = localizedCancelTitle } }
    public var isAvailable: Bool { return biomericsOnly ? biometriIsAvailable : authIsAvailable }
    
    private let biomericsOnly: Bool
    private let context = LAContext()
    
    private var error: NSError?
    
    private var biometriIsAvailable: Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    private var authIsAvailable: Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
    }
    
    public init(biomericsOnly: Bool) {
        self.biomericsOnly = biomericsOnly
    }
    
    public func check(completion: @escaping (Result) -> Void) {
        if isAvailable {
            if biomericsOnly {
                biometric(completion: completion)
            } else {
                common(completion: completion)
            }
        } else {
            completion(.failure(error))
        }
    }
    
    private func biometric(completion: @escaping (Result) -> Void) {
        evaluate(.deviceOwnerAuthenticationWithBiometrics, completion: completion)
    }
    
    private func common(completion: @escaping (Result) -> Void) {
        evaluate(.deviceOwnerAuthentication, completion: completion)
    }
    
    private func evaluate(_ policy: LAPolicy, completion: @escaping (Result) -> Void) {
        context.evaluatePolicy(policy, localizedReason: reason) { result, error in
            if result {
                completion(.success)
            } else if let accesError = error as? LAError {
                switch accesError.code {
                case LAError.userCancel: completion(.denied)
                default: completion(.failure(accesError))
                }
            } else {
                completion(.failure(error))
            }
        }
    }
 }

// MARK: - Result

public extension PSAccessManager {
    
    enum Result {
        
        case success
        case denied
        case failure(Error?)
    }
}
