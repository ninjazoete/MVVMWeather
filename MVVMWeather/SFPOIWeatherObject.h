//
//  SFPOIWeatherObject.h
//  MVVMWeather
//
//  Created by Andrzej Spiess on 16/02/15.
//  Copyright (c) 2015 Sweaty Fingers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Realm.h>

@interface SFPOIWeatherObject : RLMObject

@property (nonatomic, copy) NSString *poiName;
@property (nonatomic, assign) CGFloat poiTemp;
@property (nonatomic, assign) CGFloat poiPressure;
@property (nonatomic, copy) NSString *poiWeatherDescription;

@end
