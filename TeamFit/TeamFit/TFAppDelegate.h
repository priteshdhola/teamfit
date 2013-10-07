//
//  TFAppDelegate.h
//  TeamFit
//
//  Created by pritesh patel on 9/2/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "TFViewController.h"
#import "TFDashboardViewController.h"

@interface TFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TFDashboardViewController *mainViewController;
@property (strong, nonatomic) TFViewController* loginViewController;
- (void)openSession;
@end
