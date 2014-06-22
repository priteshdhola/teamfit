//
//  TFActivityResultsViewController.h
//  TeamFit
//
//  Created by pritesh patel on 10/12/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Activity.h"


@interface TFActivityResultsViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) Activity *myActivity;

@property (nonatomic, strong) NSMutableArray *mylocations;
@property (nonatomic, strong) NSString *totalTime;
@property (nonatomic, strong) NSString *totalDistance;

@property (strong, nonatomic) IBOutlet UILabel *labelTotalTime;
@property (strong, nonatomic) IBOutlet UILabel *labelTotalDistance;
- (IBAction)end:(id)sender;



@end
