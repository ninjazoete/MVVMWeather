//
//  SFWeatherNetworkManager.m
//  MVVMWeather
//
//  Created by Andrzej Spiess on 16/02/15.
//  Copyright (c) 2015 Sweaty Fingers. All rights reserved.
//

#import "SFWeatherNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "SFPOIWeatherObjectParser.h"
#import "SFPOIWeatherObject.h"
#import <Realm.h>

static NSString *weatherAPIKEY = @"c695859102d04a11446f09890ea634e0";

// API Keys
static NSString *weatherParameterAPIKey = @"APPID";
static NSString *weatherParameterCityKey = @"q";

@implementation SFWeatherNetworkManager

+ (SFWeatherNetworkManager *)sharedManager {
    static SFWeatherNetworkManager *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SFWeatherNetworkManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Public API

- (void)requestWeatherDataForCity:(NSString *)cityName withCompletionBlock:(void (^)(SFPOIWeatherObject *))completionBlock {
    
    SFPOIWeatherObject *weatherObject = [self existingWeatherObjectOfName:cityName];
    
    if(weatherObject) {
        completionBlock(weatherObject);
    } else {
        
        NSDictionary *parameters = @{weatherParameterCityKey : cityName, weatherParameterAPIKey : weatherAPIKEY};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://api.openweathermap.org/data/2.5/weather" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@", responseObject);
            NSLog(@"%@", operation.request);
            
            SFPOIWeatherObject *parsedWeatherObject = [SFPOIWeatherObjectParser weatherObjectFromJSONDictionary:responseObject];
            
            if(parsedWeatherObject && completionBlock) {
                completionBlock(parsedWeatherObject);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
            
            SFPOIWeatherObject *existingWeatherObject = [self existingWeatherObjectOfName:cityName];
            
            if(existingWeatherObject) {
                completionBlock(existingWeatherObject);
            }
            
        }];
    }
}

#pragma mark - Private

- (SFPOIWeatherObject *)existingWeatherObjectOfName:(NSString *)cityName {
    
    // Check for existing object.
    SFPOIWeatherObject *existingWeatherObject = nil;
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"poiName = %@", cityName];
    RLMResults *weatherObjects = [SFPOIWeatherObject objectsWithPredicate:namePredicate];
    
    if(weatherObjects.count > 0) {
        existingWeatherObject = weatherObjects.firstObject;
    }
    
    return existingWeatherObject;
}

@end
