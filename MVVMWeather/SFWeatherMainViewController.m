//
//  ViewController.m
//  MVVMWeather
//
//  Created by Andrzej Spiess on 16/02/15.
//  Copyright (c) 2015 Sweaty Fingers. All rights reserved.
//

#import "SFWeatherMainViewController.h"
#import "SFWeatherNetworkManager.h"
#import "SFPOIWeatherViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SFWeatherMainViewController () <UITextFieldDelegate>

// View related.
@property (weak, nonatomic) IBOutlet UILabel *viewCityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewPressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *viewCityNameTextField;

// ViewModel related.
@property (nonatomic, strong) SFPOIWeatherViewModel *weatherViewModel;


@end

@implementation SFWeatherMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weatherViewModel = [[SFPOIWeatherViewModel alloc] init];
    
    // Setup observing with RAC.
    // City name observe.
    [RACObserve(self.weatherViewModel, weatherCityName) subscribeNext:^(NSString *n_weatherCityName) {
        self.viewCityNameLabel.text = n_weatherCityName;
    }];
    
    // Pressure observe
    [RACObserve(self.weatherViewModel, weatherPressure) subscribeNext:^(NSString *n_weatherPressure) {
        self.viewPressureLabel.text = n_weatherPressure;
    }];
    
    // Temp observe.
    [RACObserve(self.weatherViewModel, weatherTemp) subscribeNext:^(NSString *n_weatherTemp) {
        self.viewTempLabel.text = n_weatherTemp;
    }];
    
    // Weather description observe.
    [RACObserve(self.weatherViewModel, weatherDescription) subscribeNext:^(NSString *n_weatherDescription) {
        self.viewDescriptionLabel.text = n_weatherDescription;
    }];
}

#pragma mark - Actions

- (IBAction)getWeatherAction:(id)sender {
    
    if(![self.viewCityNameTextField.text isEqualToString:@""]) {
        
        SFWeatherNetworkManager *manager = [SFWeatherNetworkManager sharedManager];
        [manager requestWeatherDataForCity:self.viewCityNameTextField.text withCompletionBlock:^(SFPOIWeatherObject *poi) {
            
            // Pass to view model object to prepare presentation stuff.
            [self.weatherViewModel setWeatherModelObject:poi];
        }];
    }
}

#pragma mark - Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
