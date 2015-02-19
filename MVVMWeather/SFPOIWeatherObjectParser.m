//
//  SFPOIWeatherObjectParser.m
//  MVVMWeather
//
//  Created by Andrzej Spiess on 19/02/15.
//  Copyright (c) 2015 Sweaty Fingers. All rights reserved.
//

#import "SFPOIWeatherObjectParser.h"
#import <Realm.h>

static NSString *const kSFWeatherObjectNameKey = @"name";
static NSString *const kSFWeatherObjectPressureKey = @"pressure";
static NSString *const kSFWeatherObjectTempKey = @"temp";
static NSString *const kSFWeatherObjectWeatherDescKey = @"description";

// Inter keys.
static NSString *const kSFWeatherAPIMainKey = @"main";
static NSString *const kSFWeatherAPIWeatherKey = @"weather";



@implementation SFPOIWeatherObjectParser

+ (SFPOIWeatherObject *)weatherObjectFromJSONDictionary:(NSDictionary *)dictionary {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    __block SFPOIWeatherObject *weatherObject = nil;
    
    [realm transactionWithBlock:^{
        
        weatherObject = [[SFPOIWeatherObject alloc] init];
        
        NSDictionary *weatherDetailsDict = dictionary[kSFWeatherAPIMainKey];
        NSArray *weatherDescArray = dictionary[kSFWeatherAPIWeatherKey];
        
        NSDictionary *weatherDescDict = weatherDescArray.firstObject;
        
        weatherObject.poiName = dictionary[kSFWeatherObjectNameKey];
        weatherObject.poiTemp = [weatherDetailsDict[kSFWeatherObjectTempKey] floatValue];
        weatherObject.poiPressure = [weatherDetailsDict[kSFWeatherObjectPressureKey] floatValue];
        weatherObject.poiWeatherDescription = weatherDescDict[kSFWeatherObjectWeatherDescKey];

        [realm addObject:weatherObject];
        
    }];
    
    
    return weatherObject;
}

@end
