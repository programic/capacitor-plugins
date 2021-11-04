import Foundation
import Capacitor
import LocalAuthentication

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */

@objc(BiometricPlugin)
public class BiometricPlugin: CAPPlugin {
    typealias JSObject = [String:Any]
    
    @objc func isAvailable(_ call: CAPPluginCall) {
        let context = LAContext()
        var error: NSError?
        var obj = JSObject()
        
        obj["isAvailable"] = false
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            obj["isAvailable"] = true
        }
        
        switch context.biometryType {
        case .touchID:
            obj["biometryType"] = 1
        case .faceID:
            obj["biometryType"] = 2
        default:
            obj["biometryType"] = 0
        }
        
        call.resolve(obj)
    }
    
    @objc func verifyIdentity(_ call: CAPPluginCall){
        let context = LAContext()
        var canEvaluateError: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &canEvaluateError){
            
            let reason = call.getString("reason") ?? "For biometric authentication"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, evaluateError) in
                
                if success {
                    call.resolve()
                }else{
                    var errorCode = "0"
                    guard let error = evaluateError
                    else {
                        call.reject("Biometrics Error", "0")
                        return
                    }
                    
                    switch error._code {
                    
                    case LAError.authenticationFailed.rawValue:
                        errorCode = "10"
                        
                    case LAError.appCancel.rawValue:
                        errorCode = "11"
                        
                    case LAError.invalidContext.rawValue:
                        errorCode = "12"
                        
                    case LAError.notInteractive.rawValue:
                        errorCode = "13"
                        
                    case LAError.passcodeNotSet.rawValue:
                        errorCode = "14"
                        
                    case LAError.systemCancel.rawValue:
                        errorCode = "15"
                        
                    case LAError.userCancel.rawValue:
                        errorCode = "16"
                        
                    case LAError.userFallback.rawValue:
                        errorCode = "17"
                        
                    default:
                        errorCode = "0" // Biometrics unavailable
                    }
                    
                    call.reject(error.localizedDescription, errorCode, error)
                }
                
            }
            
        }else{
            call.reject("Authentication not available")
        }
    }
}
