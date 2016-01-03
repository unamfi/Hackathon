//
//  Ericsson.swift
//  Hackathon
//
//  Created by Julio César Guzman on 1/2/16.
//  Copyright © 2016 Julio. All rights reserved.
//

import Foundation
import Alamofire

//    - (void) login:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;

//     KNOW THE VEHICLE

//    - (void) checkRequestStatus:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) viewDiagnosticData:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) getVehicleStatus:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) getBusInfo:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;

//     CONTROL THE VEHICLE

//    - (void) doorUnlock:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) doorLock:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) engineOn:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) engineOff:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) honkAndBlink:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) getVehicleStatus:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;

//     KNOW THE PASSENGER

//    - (void) addAPassenger:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) updateAPassenger:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) deleteAPassenger:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) viewAPassenger:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) searchPassengers:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;

//     KNOW THE PASSENGER

//    - (void) consume:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) getProducts:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) getUserPurchases:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) purchase:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
//    - (void) refund:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;

// Old params
//    var params : [String: AnyObject] = ["longitude": 55.578545, "latitude": 14.254875, "accuracy": 6, "route" : ["vin" : "3115361391" ]]

typealias BooleanClosure = (Bool) -> ()
typealias SuccessClosure = BooleanClosure

typealias AnyObjectByStringDictionary = [String: AnyObject]

typealias HandleRequestID = (Int) -> ()

typealias InfoClosure = (AnyObjectByStringDictionary) -> ()

typealias GetRequestIDClosure = (HandleRequestID) -> ()

class EricssonManager {

    private let logInParameters = ["username" : "provider", "pin": "1234", "vin" : "3115361391"]
    private var parameters = ["route" : ["vin" : "3115361391"]]
    
    private func addRequestIDToParameters(requestID : Int) {
        self.parameters["route"]!["requestId"] = String(requestID)
    }
    
    private var sharedASDPManager : ASDPRequestManager {
        return ASDPRequestManager.sharedManager()
    }

    private func dictionaryWithData(data : NSData) -> AnyObjectByStringDictionary {
        return try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! AnyObjectByStringDictionary
    }
    
    func logIn(success: SuccessClosure) {
        sharedASDPManager.login(logInParameters) { (asdpResult) -> Void in
            success(asdpResult.isSuccess)
        }
    }
    
    private func getRequestID(handler: HandleRequestID, asdpMethod : ([NSObject:AnyObject]!, ASDPRequestCompletionBlock!)->() ){
        asdpMethod(parameters) { (result) -> Void in
            let data = result.bodyData
            let infoDictionary = self.dictionaryWithData(data)
            let requestID = infoDictionary["requestId"] as! Int
            handler(requestID)
        }
    }
        
    private func checkRequestStatus(info : InfoClosure) {
        sharedASDPManager.checkRequestStatus(parameters) { (result) -> Void in
            let dataDictionary = self.dictionaryWithData(result.bodyData)
            info(dataDictionary)
        }
    }
    
    private func getStatus(info: InfoClosure, getRequestIDClosure : GetRequestIDClosure) {
        getRequestIDClosure({ (requestID) -> () in
            self.addRequestIDToParameters(requestID)
            self.checkRequestStatus(info)
        })
    }
}

extension EricssonManager {
    private func getVehicleRequestID(handler : HandleRequestID) {
        getRequestID(handler, asdpMethod: sharedASDPManager.getVehicleStatus)
    }
    
    func getVehicleStatus(info : InfoClosure) {
        getStatus(info, getRequestIDClosure: self.getVehicleRequestID)
    }
}

extension EricssonManager {
    private func getBusRequestID(handler : HandleRequestID) {
        getRequestID(handler, asdpMethod: sharedASDPManager.getBusInfo)
    }
    
    func getBusStatus(info : InfoClosure) {
        getStatus(info, getRequestIDClosure: self.getBusRequestID)
    }
}

extension EricssonManager {
    private func getDiagnosticDataRequestID(handler : HandleRequestID) {
        getRequestID(handler, asdpMethod: sharedASDPManager.viewDiagnosticData)
    }
    
    func getDiagnosticDataStatus(info : InfoClosure) {
        getStatus(info, getRequestIDClosure: self.getDiagnosticDataRequestID)
    }
}
