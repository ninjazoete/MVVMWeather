//
//  SFWeatherNetworkManager.h
//  MVVMWeather
//
//  Created by Andrzej Spiess on 16/02/15.
//  Copyright (c) 2015 Sweaty Fingers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPOIWeatherObject.h"

@interface SFWeatherNetworkManager : NSObject

+ (SFWeatherNetworkManager *)sharedManager;

- (void)requestWeatherDataForCity:(NSString *)cityName withCompletionBlock:(void (^)(SFPOIWeatherObject *))completionBlock;

@end
