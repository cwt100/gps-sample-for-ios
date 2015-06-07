//
//  GPSModel.m
//  GPSSample
//
//  Created by Cherry_Cheng on 2015/6/6.
//  Copyright (c) 2015年 cwt100. All rights reserved.
//

#import "GPSModel.h"
#import <CoreLocation/CoreLocation.h>

@interface GPSModel ()<CLLocationManagerDelegate>

@end

@implementation GPSModel{
    
    CLLocationManager *localcationManager;
    NSTimer *updateLocationTimer;
}

#pragma mark - init
- (id)init {
    self = [super init];
    if (self) {
        [self initLocationManager];
    }
    return self;
}

- (void)initLocationManager {
    
    if (localcationManager == nil) {
        
        localcationManager = [[CLLocationManager alloc] init];
        localcationManager.delegate = self;
    }
    
    localcationManager.desiredAccuracy = kCLLocationAccuracyBest;
    localcationManager.distanceFilter = kCLHeadingFilterNone;//每秒更新
    
    if ([localcationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [localcationManager requestWhenInUseAuthorization];
    }
}

#pragma mark - Start / Stop
- (void)startUpdateLocation {
    [self initLocationManager];
    [localcationManager startUpdatingLocation];
}

- (void)stopUpdateLocation {
    [localcationManager stopUpdatingLocation];
}

- (void)startUpdateLocationWithTimeInterval:(NSTimeInterval)timeInterval {
    
    [self stopUpdateLocationTimer];
    
    [self startUpdateLocation];
    updateLocationTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                           target:self
                                                         selector:@selector(startUpdateLocation)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)stopUpdateLocationTimer {
    
    if (updateLocationTimer) {
        [updateLocationTimer invalidate];
        updateLocationTimer = nil;
    }
}

#pragma mark - LocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    [self stopUpdateLocation];
    
    [self.delegate gpsModel:self didUpdateLocationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
}

@end
