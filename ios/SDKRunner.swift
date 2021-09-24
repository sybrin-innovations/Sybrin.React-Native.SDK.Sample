// The class that we will run our Swift code from and call the SDK implementation


//=======================================
// For more information regarding the impoementation of the Sybrin Identity SDK visit our documentation page at: https://innovations.gitbook.io/identity-ios/
//=======================================

import Foundation
import Sybrin_iOS_Identity
import UIKit

// It is important to mark the class and its method with the @objc tag. This allows Objective C to access these components.

@objc(SDKRunner)
class SDKRunner : NSObject {
  
  // License required to run the SDK features. This is provided by Sybrin.
  let IdentitylicenseKey: String = "qlUumaKiLEiEAfiuBs6LG5aLcfvbLEbCFaWH0mmxZjhZWbqNqKXnGt6NlI7X9kA1Pq+B66AF5+RIMcxoHz07kI7yGxjqrq6Yi0LpLZWlQMMEi79zQhdMgzoMzR0W2sLTgeaX2Bt/iVr4lNB6YSK1oQrbOKtKjH7x41XRuyZLgzV/d4QaoXMBw+I33mgwEOmkzAISz8vide0uq1Vj06EyHbe+4qfCLYPB/6i6kDV2D36aDELr59Ekh2w65LOxpj3bUFGUtYIOxP0uiI9xhELd36IKumK9Kfhy7VbJWeg6rtEXaZG/56lt4C7GNkZWWFfoin2AaEjvn4zJkEodO2gta3v4SPPi6U5m7nydH22A9luyrjeMK2001ufczrAvJxTjtoHhr/cevPugK12BSuNegTkV+UCB9WXCAyrpDIZnuaDmEogsFofD2Yy7/1TK21WEyEd4ilTD9gwpThsvPBHRUJPmwprUq4skZP9/QxMbvK9S/ZLguEibk5o4PhKPqcFd"
  
  
  // The RCTResponseSendBlock is the class used to send data back to React Native. It is important to mark it as @escaping to ensure it gets garbage collected.
  @objc
  func scan(_ callback: @escaping RCTResponseSenderBlock){
    
    // The Sybrin SDK has to run from an existing UIViewController. To get an instance of the current view controller displayed by React Native we run the below code and pass that instance to the SDK as a parameter.
    
    DispatchQueue.main.async{
      
      // Get instance of current UIViewController.
      let rootViewController = UIApplication.shared.delegate?.window??.rootViewController
      
      guard let rootViewController = rootViewController else {
        return
      }
      
      // Call the Sybrin Identity SDK implementation.
      self.runIdentitySDK(rootViewController, callback: callback)
      
    }
  }
  
  func runIdentitySDK(_ viewController: UIViewController,  callback: @escaping RCTResponseSenderBlock){
    
    // Init the configuration needed to run the Sybrin Identity SDK.
    let sybrinConfig = SybrinIdentityConfiguration(license: IdentitylicenseKey)
    SybrinIdentity.shared.configuration = sybrinConfig
    
    // Run the Sybrin Identity SDK with youre prefered paramters.
    SybrinIdentity.shared.scanPassport(on: viewController, for: .SouthAfrica)
    {(result, message) in
      
      print("Done Launching Passport scan")
      
    }
  success: { (model) in
    
    // Cast the generic DocumentModel to the specific expected model to access the properties related to that document.
    if let southAfricaPassportModel = model as? SouthAfricaPassportModel {
      let value: String = "Processed:  \(southAfricaPassportModel.names ?? "") \(southAfricaPassportModel.identityNumber ?? "")"
      
      // Return the sucessful data to React Native through a callback.
      callback([value])
    }
    
    print("Success scanning passport")
    
  } failure: { (message) in
    
    callback(["SDK Failure due to : \(message)"])
    print("Failure scanning passport")
    
  } cancel: {
    
    callback(["Scanning cancelled"])
    print("Passport scanning cancelled")
    
  }
  }
}

