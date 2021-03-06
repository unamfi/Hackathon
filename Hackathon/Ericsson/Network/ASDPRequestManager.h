//
//  ASDPRequestManager.h
//  ASDP Sampler
//
//  Created by Jeremy White on 8/19/14.
//  Copyright (c) 2014 AT&T Foundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASDPResult.h"
#import "APISpec.h"

@interface ASDPRequestManager : NSObject

typedef void (^ ASDPRequestCompletionBlock)(ASDPResult *result);

+ (ASDPRequestManager *) sharedManager;

@property (nonatomic, strong, readonly) NSString *vin;
@property (nonatomic, strong, readonly) NSString *authToken;
@property (nonatomic, strong, readonly) NSString *apiKey;

- (void) executeAPI:(APISpec *)spec routeParams:(NSDictionary *)routeParams requestParams:(NSDictionary *)requestParams completion:(ASDPRequestCompletionBlock)completion;

// START 2.6.x APIs
- (void) signUp:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) validateOneTimePassword:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) setPIN:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) login:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) doorUnlock:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) doorLock:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) engineOn:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) engineOff:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) honkAndBlink:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) checkRequestStatus:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) viewDiagnosticData:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) getVehicleStatus:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) getBusInfo:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
/*
- (void) openTrunk:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) honk:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) blink:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) carAlarmOn:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) carAlarmOff:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
*/
// END 2.6.x APIs

// START 2.12.x APIs
- (void) consume:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) getProducts:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) getUserPurchases:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) purchase:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) refund:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
// END 2.12.x APIs

// START 2.13.x APIs
- (void) addASubscriber:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) addASubscriberAndVehicle:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) updateASubscriber:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) deleteASubscriber:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) viewASubscriber:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) searchSubscribers:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
// END 2.13.x APIs


// START 2.14.x APIs
- (void) addAPassenger:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) updateAPassenger:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) deleteAPassenger:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) viewAPassenger:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) searchPassengers:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
// END 2.14.x APIs

// START 2.16.x APIs
- (void) addAVehicle:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) updateAVehicle:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) deleteAVehicle:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) viewAVehicle:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) updateVehicleUsers:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) deleteVehicleUsers:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
- (void) searchVehicles:(NSDictionary *)params completion:(ASDPRequestCompletionBlock)completion;
// END 2.16.x APIs

- (void) logout;

@end
