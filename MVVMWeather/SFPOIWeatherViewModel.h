//
//  SFPOIWeatherViewModel.h
//  MVVMWeather
//
//  Created by Andrzej Spiess on 19/02/15.
//  Copyright (c) 2015 Sweaty Fingers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPOIWeatherObject.h"

@interface SFPOIWeatherViewModel : NSObject

@property (nonatomic, copy) NSString *weatherCityName;
@property (nonatomic, copy) NSString *weatherDescription;
@property (nonatomic, copy) NSString *weatherPressure;
@property (nonatomic, copy) NSString *weatherTemp;

- (void)setWeatherModelObject:(SFPOIWeatherObject *)weatherModel;


@end
