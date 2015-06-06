//
//  ViewController.m
//  GPSSample
//
//  Created by Cherry_Cheng on 2015/6/6.
//  Copyright (c) 2015年 cwt100. All rights reserved.
//

#import "ViewController.h"
#import "GPSModel.h"

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
    
    [self.onceButton addTarget:self
                        action:@selector(onceButtonClick:)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onceButtonClick:(id)sender {
    [gpsModel startUpdateLocation];
}

#pragma mark - GPSModel Delegate
- (void)gpsModel:(GPSModel *)gpsModel didUpdateLocationWithLatitude:(double)latitude longitude:(double)longitude {
    
    self.latitudeLabel.text = [NSString stringWithFormat:@"%.6f", latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%.6f", longitude];
}

@end
