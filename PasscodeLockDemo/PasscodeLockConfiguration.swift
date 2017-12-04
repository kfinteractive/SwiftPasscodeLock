//
//  PasscodeLockConfiguration.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/29/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation
import PasscodeLock

struct PasscodeLockConfiguration: PasscodeLockConfigurationType {
    let repository: PasscodeRepositoryType
    let passcodeLength = 4
    var isBiometricAuthenticationAllowed = true
    let shouldRequestTouchIDImmediately = true
    let maximumInccorectPasscodeAttempts = -1
    var touchIdReason: String? = nil
    var touchIDAuthenticationAllowableReuseDuration: TimeInterval = 0

    init(repository: PasscodeRepositoryType) {
        
        self.repository = repository
    }
    
    init() {
        
        self.repository = UserDefaultsPasscodeRepository()
    }
}
