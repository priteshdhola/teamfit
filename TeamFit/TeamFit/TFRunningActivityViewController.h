//
//  TFRunningActivityViewController.h
//  TeamFit
//
//  Created by pritesh patel on 9/8/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class TFRunningActivityViewController;

@protocol TFRunningActivityViewControllerDelegate <NSObject>
//- (void)runningActivityViewControllerDidCancel: (TFRunningActivityViewController *)controller;
- (void)runningActivityViewControllerDidEnd: (TFRunningActivityViewController *)controller;
@end

@interface TFRunningActivityViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) id <TFRunningActivityViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UILabel *timerLabel;
@property (nonatomic, retain) NSTimer *stopTimer;
@property (nonatomic, retain) NSDate *startDate;

@property (nonatomic, strong) NSMutableArray *mylocations;

- (IBAction)end:(id)sender;

@end


