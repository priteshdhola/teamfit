//
//  Activity.h
//  TeamFit
//
//  Created by pritesh patel on 9/2/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject
@property (nonatomic, copy) NSString *activityId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSMutableArray *friends;

@end
