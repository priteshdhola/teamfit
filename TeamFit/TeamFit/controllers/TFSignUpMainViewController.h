//
//  TFSignUpMainViewController.h
//  TeamFit
//
//  Created by pritesh patel on 10/4/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFSignUpMainViewController;

@protocol TFSignUpMainViewControllerDelegate <NSObject>
- (void)signUpMainViewControllerDidCancel: (TFSignUpMainViewController *)controller;
@end

@interface TFSignUpMainViewController : UIViewController
@property (nonatomic, weak) id <TFSignUpMainViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *signUpEmail;
@property (strong, nonatomic) IBOutlet UITextField *signUpPassword;
- (IBAction)signUpSubmit:(id)sender;
- (IBAction)cancel:(id)sender;

@end
