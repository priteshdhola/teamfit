//
//  UserLocation.h
//  TeamFit
//
//  Created by Nirav Patel on 9/28/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLocation : NSObject
{
    
    NSNumber *latitude, *longitude, *timestamp;
}

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *timestamp;

@end
