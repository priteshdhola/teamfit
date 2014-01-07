//
//  TFSignUpExtraViewController.h
//  TeamFit
//
//  Created by pritesh patel on 10/4/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class TFSignUpExtraViewController;
//
//@protocol TFSignUpExtraViewControllerDelegate <NSObject>
//- (void)signUpExtraViewControllerDidSkip: (TFSignUpExtraViewController *)controller;
//@end

@interface TFSignUpExtraViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *userAgeTextbox;
@property (strong, nonatomic) IBOutlet UITextField *userHeightTextBox;
@property (strong, nonatomic) IBOutlet UITextField *userWeightTextBox;
@property (strong, nonatomic) IBOutlet UITextField *userSexTextBox;
- (IBAction)userExtraDone:(id)sender;
- (IBAction)userExtraSkip:(id)sender;

@end
