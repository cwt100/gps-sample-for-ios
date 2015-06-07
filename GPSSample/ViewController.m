//
//  ViewController.m
//  GPSSample
//
//  Created by Cherry_Cheng on 2015/6/6.
//  Copyright (c) 2015年 cwt100. All rights reserved.
//

#import "ViewController.h"
#import "GPSModel.h"

#define REPEAT_UPDATE_TIME  5

@interface ViewController () <GPSModelDelegate>

@end

@implementation ViewController {
    GPSModel *gpsModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    gpsModel  = [[GPSModel alloc] init];
    gpsModel.delegate = self;
    
    [self initButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button
- (void)initButton {
    
    [self.onceButton addTarget:self
                        action:@selector(onceButtonClick:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.repeatButton addTarget:self
                          action:@selector(repeatStartButtonClick:)
                forControlEvents:UIControlEventTouchUpInside];
}

- (void)onceButtonClick:(id)sender {
    [gpsModel startUpdateLocation];
}

- (void)repeatStartButtonClick:(id)sender {
    
    [self.repeatButton setTitle:@"STOP" forState:UIControlStateNormal];
    [self.repeatButton addTarget:self
                          action:@selector(repeatStopButtonClick:)
                forControlEvents:UIControlEventTouchUpInside];
    
    [gpsModel startUpdateLocationWithTimeInterval:REPEAT_UPDATE_TIME];
}

- (void)repeatStopButtonClick:(id)sender {
    
    [self.repeatButton setTitle:@"REPEAT" forState:UIControlStateNormal];
    [self.repeatButton addTarget:self
                          action:@selector(repeatStartButtonClick:)
                forControlEvents:UIControlEventTouchUpInside];
    
    [gpsModel stopUpdateLocationTimer];
}

#pragma mark - GPSModel Delegate
- (void)gpsModel:(GPSModel *)gpsModel didUpdateLocationWithLatitude:(double)latitude longitude:(double)longitude {
    
    NSLog(@"latitude: %.6f, longitude: %.6f", latitude, longitude);
    self.latitudeLabel.text = [NSString stringWithFormat:@"%.6f", latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%.6f", longitude];
}

@end
