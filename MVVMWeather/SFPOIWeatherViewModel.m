//
//  SFPOIWeatherViewModel.m
//  MVVMWeather
//
//  Created by Andrzej Spiess on 19/02/15.
//  Copyright (c) 2015 Sweaty Fingers. All rights reserved.
//

#import "SFPOIWeatherViewModel.h"

@interface SFPOIWeatherViewModel()

@property (nonatomic, strong) SFPOIWeatherObject *weatherModelObject;

@end

@implementation SFPOIWeatherViewModel
@synthesize weatherModelObject = _weatherModelObject;

- (void)setWeatherModelObject:(SFPOIWeatherObject *)weatherModel {
    
    _weatherModelObject = weatherModel;
    
    self.weatherCityName = [NSString stringWithFormat:@"City: %@", weatherModel.poiName];
    self.weatherDescription = [NSString stringWithFormat:@"Status: %@", weatherModel.poiWeatherDescription];
    self.weatherPressure = [NSString stringWithFormat:@"Pressure: %@", @(weatherModel.poiPressure)];
    self.weatherTemp = [NSString stringWithFormat:@"Temp: %@", @(weatherModel.poiTemp)];
}


@end
