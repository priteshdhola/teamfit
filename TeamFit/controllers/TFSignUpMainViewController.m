//
//  TFSignUpMainViewController.m
//  TeamFit
//
//  Created by pritesh patel on 10/4/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "TFSignUpMainViewController.h"
#import "TFSignUpExtraViewController.h"

@interface TFSignUpMainViewController ()

@end

@implementation TFSignUpMainViewController
@synthesize signUpEmail;
@synthesize signUpPassword;
NSInteger flag;

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
    [self.signUpEmail becomeFirstResponder];
    self.navigationController.navigationBar.barTintColor  = [UIColor blackColor];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpSubmit:(id)sender {
    // Build JSON Object first
    /***************************************************/
    // make the inner dictionaries (probably would use a for loop for this)
    NSDictionary *dict1 = [[NSDictionary alloc]
                           initWithObjectsAndKeys:[self.signUpEmail text],@"email",
                           [self.signUpPassword text],@"password",
                           nil];
    
    // now put the array in a dictionary
    NSDictionary *finalDict = [[NSDictionary alloc] initWithObjectsAndKeys:dict1, @"userData", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:finalDict options:0 error:&error];
    
    //Json string for debugging
    NSString *jsonString = [[NSString alloc] init];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    /****************** Make the Post call for login ************************/
    NSURL *locationOfWebService = [NSURL URLWithString:@"http://localhost:8080/tracksafe/auth"];
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc]initWithURL:locationOfWebService];
    NSHTTPURLResponse *response = nil;
    
    [theRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:jsonData];
    
    // Make the request and capture the data
    NSData *urlData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    //    NSLog(@"Response code: %d", [response statusCode]);
    //    NSLog(@"Response ==> %@", responseData);
    
    // If response is 200 than success
    if ([response statusCode] ==200)
    {
        flag=1;
        NSLog(@"SignUp SUCCESS");
        // This is custom segue call. This way segue only gets called when user enters correct username and password
        // We also have to make sure that we connect UI story board to next story board via ctrl-drag and not the login button.
        [self performSegueWithIdentifier:@"additionalInfo" sender:self];
    } else {
        if (error) NSLog(@"Login FAILURE: %@", error);
        [self alertStatus:@"Please cheack your credentials" :@"Login Failed!"];
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *) title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)cancel:(id)sender {
    [self.delegate signUpMainViewControllerDidCancel:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"additionalInfo"] && flag == 1) {
//        UINavigationController *navigationController = segue.destinationViewController;
//        TFSignUpExtraViewController *signUpViewController = [[navigationController viewControllers] objectAtIndex:0];
        TFSignUpExtraViewController *destination = [segue destinationViewController];
    }
}
@end
