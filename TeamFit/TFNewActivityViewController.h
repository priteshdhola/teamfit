//
//  TFNewActivityViewController.h
//  TeamFit
//
//  Created by pritesh patel on 9/2/13.
//  Copyright (c) 2013 abc. All rights reserved.
//
#import "Activity.h"

@class TFNewActivityViewController;

@protocol TFNewActivityViewControllerDelegate <NSObject>
- (void)newActivityViewControllerDidCancel: (TFNewActivityViewController *)controller;
//- (void)newActivityViewControllerDidDone: (TFNewActivityViewController *)controller;

- (void)newActivityViewController: (TFNewActivityViewController *)controller didAddActivity:(Activity *)activity;
@end

@interface TFNewActivityViewController : UIViewController <TFNewActivityViewControllerDelegate,UITextFieldDelegate>
@property (nonatomic, weak) id <TFNewActivityViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)dateChanged:(id)sender;
- (IBAction)doneEditing:(id)sender;

// UI
@property (strong, nonatomic) IBOutlet UITextField *activityNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *activityDateTextField;
@property (strong, nonatomic) IBOutlet UITextField *activityTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *activityMembersTextField;

// Date picker 
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSDate *dateandtime;
@property (strong, nonatomic) NSString *dateValue;
@property (strong, nonatomic) NSString *timeValue;

@end
