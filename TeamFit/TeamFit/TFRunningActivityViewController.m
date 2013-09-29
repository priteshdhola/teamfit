//
//  TFRunningActivityViewController.m
//  TeamFit
//
//  Created by pritesh patel on 9/8/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "TFRunningActivityViewController.h"
#import "UserLocation.h"
#define kPollingInterval 1.0
#import "SBJson.h"

@implementation TFRunningActivityViewController

#define METERS_PER_MILE 1609.344

@synthesize mylocations;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mapView.delegate = self;
    self.startDate = [NSDate date];
    self.stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                 target:self
                                               selector:@selector(updateTimer)
                                               userInfo:nil
                                                repeats:YES];
    self.navigationController.navigationBar.barTintColor  = [UIColor blackColor];
    self.mylocations = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)end:(id)sender
{
 //   [self.delegate runningActivityViewControllerDidEnd:self];
//    [self.navigationController popToRootViewControllerAnimated:TRUE];
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateTimer{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    self.timerLabel.text = timeString;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    CLLocationCoordinate2D curCoordinate = userLocation.coordinate;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(curCoordinate, 1*METERS_PER_MILE, 1*METERS_PER_MILE);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    //store current location into array
    [self.mylocations addObject: [NSValue valueWithMKCoordinate: curCoordinate]];
    
    //Create model
    UserLocation *userLoc = [[UserLocation alloc] init];
    userLoc.latitude = [[NSNumber alloc] initWithFloat:curCoordinate.latitude];
    userLoc.longitude = [[NSNumber alloc] initWithFloat:curCoordinate.longitude];
    userLoc.timestamp = [[NSNumber alloc] initWithFloat: floor(userLocation.location.timestamp.timeIntervalSince1970 * 1000) ];
    
    //store current location on server
    NSError* error;
    //[NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes: userLoc]  options:kNilOptions error:&error];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    //writer.humanReadable = YES;
    //NSString* json = [writer stringWithObject:userLoc error:&error];
    
    //NSDictionary *jsonDict = [NSDictionary dictionaryWithObject:userLoc forKey:@"userLocation" ];
    
    //NSString *jsonRequest = [jsonDict JSONRepresentation ] ;
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"locationData\": {\"latitude\": \"%@\",\"longitude\": \"%@\",\"timestamp\": \"%@\"}}",userLoc.latitude,userLoc.longitude,userLoc.timestamp];
    
    NSLog(@"The request data is %@",jsonRequest);
    NSLog(@"Error %@", error);
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    NSInteger randomUserId = (arc4random() % 4) + 1;
    NSString* baseUrl = [ NSString stringWithFormat: @"http://localhost:8080/tracksafe/activities/1/%ld",(long)randomUserId ];
    
    NSURL *locationOfWebService = [NSURL URLWithString:baseUrl];
    NSLog(@"web url = %@",locationOfWebService);
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc]initWithURL:locationOfWebService];
    [theRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: requestData];
    
    NSError *reqErr;
    NSURLResponse *urlRes = nil;
    NSData *postRes = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&urlRes error:&reqErr];
   
    /*
    NSURLConnection *connect = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];
    if (connect) {
        NSMutableData* webData = [[NSMutableData alloc]init];
        NSLog(@"Response %@: ",webData);
    }
    else {
        NSLog(@"No Connection established");
    }
     
     */
    
    //Draw overlay of user track
    
    // while we create the route points, we will also be calculating the bounding box of our route
    // so we can easily zoom in on it.
    MKMapPoint northEastPoint;
    MKMapPoint southWestPoint;
    
    // create a c array of points.
    // MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * mylocations.count);
    CLLocationCoordinate2D coordinates[mylocations.count];
    
    for(int idx = 0; idx < mylocations.count; idx++)
    {
        NSValue * val = [mylocations objectAtIndex:idx];
        CLLocationCoordinate2D coordinate = val.MKCoordinateValue;
        coordinates[idx] = coordinate;
        //        MKMapPoint point = MKMapPointForCoordinate([mylocations objectAtIndex:idx]);
        
    }
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:self.mylocations.count];
    
    [_mapView addOverlay:polyline];
    
    //Get Other users locaitons and mark their anotation on map
   
    NSString* serverAddress = @"http://localhost:8080/tracksafe/activities/1/userLocations";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:1000];
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *apiResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    ///////////////////////// MAKING THE GET REQUEST AND PARSING THE DATA /////////////////////////////
    NSError* error2;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:apiResponse options:kNilOptions error:&error2];
    NSDictionary* allData = [json objectForKey:@"locationDataList"];
    NSArray* allUserLocations = [allData objectForKey:@"locationData"];
    
    NSMutableArray * pointArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [allUserLocations count]; i++)
    {
        NSDictionary* jsonLocation = [allUserLocations objectAtIndex:i];
        
        NSDictionary* user = [jsonLocation objectForKey:@"userData"];
        
        double latitude = [[jsonLocation objectForKey:@"latitude"] doubleValue];
        double longitude = [[jsonLocation objectForKey:@"longitude"] doubleValue];
        
        // create our coordinate and add it to the correct spot in the array
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coordinate;
        point.title = [user objectForKey:@"userName"];
        point.subtitle = @"S/He was here!!";
        
        [pointArr addObject:point];
        
    }
    [self.mapView addAnnotations:pointArr];

    // Add an annotation
   /*  MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
     point.coordinate = userLocation.coordinate;
     point.title = @"Where am I?";
     point.subtitle = @"I'm here!!!";
     
     [self.mapView addAnnotation:point];
    */
    
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor redColor];
    polylineView.lineWidth = 5.0;
    
    return polylineView;
}



@end
