//
//  TFActivityResultsViewController.m
//  TeamFit
//
//  Created by pritesh patel on 10/12/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "TFActivityResultsViewController.h"
#import "TFDashboardViewController.h"
#define METERS_PER_MILE 1609.344

@interface TFActivityResultsViewController ()

@end

@implementation TFActivityResultsViewController
@synthesize mylocations;
@synthesize totalTime;
@synthesize totalDistance;
@synthesize mapView;
@synthesize myActivity;
float paceData;

CLLocationManager *locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor  = [UIColor blackColor];

	// Do any additional setup after loading the view.
    self.labelTotalTime.text = totalTime;
    self.labelTotalDistance.text = totalDistance;//[NSString stringWithFormat:@"%.2f", totalDistance];
    self.mapView.delegate = self;
    
    NSValue * val = [mylocations objectAtIndex:0];
    CLLocationCoordinate2D zoomLocation = val.MKCoordinateValue;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];
    
    CLLocationCoordinate2D coordinates[mylocations.count];
    for(int idx = 0; idx < mylocations.count; idx++)
    {
        NSValue * val = [mylocations objectAtIndex:idx];
        CLLocationCoordinate2D coordinate = val.MKCoordinateValue;
        coordinates[idx] = coordinate;
    }
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:self.mylocations.count];
    [self.mapView addOverlay:polyline];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor redColor];
    polylineView.lineWidth = 10.0;
    
    return polylineView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)end:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"activityDone" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"activityDone"]) {
        NSLog(@"Activity ID value : %@",myActivity.activityId);
        TFDashboardViewController *destinationViewController = segue.destinationViewController;
        // Sample data
       // totalTime = @"600";
       // totalDistance = @"1.03";
        paceData = ([totalTime intValue]/60)/[totalDistance floatValue];
        
        // Update activity results
        
        NSString *soapFormat = [NSString stringWithFormat:@"{\"userActivityData\": {\"distance\": \"%@\",\"pace\": \"%d\",\"time\": \"%@T%@\",\"status\": 2}}",totalDistance,(int)roundf(paceData),myActivity.date,myActivity.time];
        
        NSLog(@"The request format is %@",soapFormat);
        NSString *urlString = [NSString stringWithFormat: @"http://localhost:8080/tracksafe/activities/%@/status/update",myActivity.activityId];
        NSURL *locationOfWebService = [NSURL URLWithString: urlString];
        NSLog(@"web url = %@",locationOfWebService);
        NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc]initWithURL:locationOfWebService];
        [theRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody:[soapFormat dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLConnection *connect = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];
        if (connect) {
            NSMutableData* webData = [[NSMutableData alloc]init];
                    NSLog(@"Response %@: ",webData);
        }
        else {
            NSLog(@"No Connection established");
        }
    }
}
@end
