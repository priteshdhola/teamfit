//
//  TFDashboardViewController.h
//  TeamFit
//
//  Created by pritesh patel on 9/2/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "TFNewActivityViewController.h"
#import "TFSelectActivityViewController.h"

@interface TFDashboardViewController : UITableViewController <TFNewActivityViewControllerDelegate, TFSelectActivityViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *activities;
- (Activity *)objectInListAtIndex:(NSUInteger)theIndex;
- (IBAction)logoutButtonWasPressed:(id)sender;
@end
