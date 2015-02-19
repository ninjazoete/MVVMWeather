//
//  SFPOIWeatherObjectParser.h
//  MVVMWeather
//
//  Created by Andrzej Spiess on 19/02/15.
//  Copyright (c) 2015 Sweaty Fingers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPOIWeatherObject.h"

@interface SFPOIWeatherObjectParser : NSObject

+ (SFPOIWeatherObject *)weatherObjectFromJSONDictionary:(NSDictionary *)dictionary;

@end
