//
//  TFSelectActivityViewController.h
//  TeamFit
//
//  Created by pritesh patel on 9/7/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import "TFRunningActivityViewController.h"


@class TFSelectActivityViewController;

@protocol TFSelectActivityViewControllerDelegate <NSObject>
- (void)selectActivityViewControllerDidCancel: (TFSelectActivityViewController *)controller;
- (void)selectActivityViewControllerDidStart: (TFSelectActivityViewController *)controller;
@end

@interface TFSelectActivityViewController : UIViewController <TFRunningActivityViewControllerDelegate>
@property (nonatomic, weak) id <TFSelectActivityViewControllerDelegate> delegate;
@property (nonatomic, strong) Activity *myActivity;
@property (strong, nonatomic) IBOutlet UITextField *selectActivityNameTextBox;
@property (strong, nonatomic) IBOutlet UITextField *selectActivityDateTextBox;
@property (strong, nonatomic) IBOutlet UITextField *selectActivityTimeTextBox;
@property (strong, nonatomic) IBOutlet UITextField *selectActivityMembersTextBox;

- (IBAction)cancel:(id)sender;
- (IBAction)start:(id)sender;
@end
