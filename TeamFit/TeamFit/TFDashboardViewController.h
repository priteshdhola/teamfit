//
//  TFDashboardViewController.h
//  TeamFit
//
//  Created by pritesh patel on 9/2/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFNewActivityViewController.h"
#import "TFOpenActivityViewController.h"

@interface TFDashboardViewController : UITableViewController <TFNewActivityViewControllerDelegate, TFOpenActivityViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *activities;

@end
