//
//  TFOpenActivityViewController.h
//  TeamFit
//
//  Created by pritesh patel on 9/2/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFOpenActivityViewController;

@protocol TFOpenActivityViewControllerDelegate <NSObject>
- (void)openActivityViewControllerDidCancel: (TFOpenActivityViewController *)controller;
- (void)openActivityViewControllerDidStart: (TFOpenActivityViewController *)controller;
@end

@interface TFOpenActivityViewController : UITableViewController
@property (nonatomic, weak) id <TFOpenActivityViewControllerDelegate> delegate;
@property (nonatomic, strong) NSObject *activity;

@property (strong, nonatomic) IBOutlet UILabel *openActivityNameTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *openActivityDateTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *openActivityTimeTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *openActivityMembersTextLabel;

- (IBAction)cancel:(id)sender;
- (IBAction)start:(id)sender;
@end
