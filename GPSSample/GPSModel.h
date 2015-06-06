//
//  GPSModel.h
//  GPSSample
//
//  Created by Cherry_Cheng on 2015/6/6.
//  Copyright (c) 2015年 cwt100. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GPSModelDelegate;

@interface GPSModel : NSObject

@property (nonatomic, strong) id<GPSModelDelegate> delegate;

- (void)startUpdateLocation;

@end

@protocol GPSModelDelegate

@optional
- (void)gpsModel:(GPSModel *)gpsModel didUpdateLocationWithLatitude:(double)latitude longitude:(double)longitude;

@end
