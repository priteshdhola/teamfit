//
//  TFViewController.m
//  TeamFit
//
//  Created by pritesh patel on 9/2/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "TFViewController.h"
#import "TFDashboardViewController.h"
#import "TFSignUpMainViewController.h"
#import "SBJson.h"
#import "TFAppDelegate.h"

@interface TFViewController ()

@end

@implementation TFViewController

@synthesize txtUsername;
@synthesize txtPassword;
NSInteger flag;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidUnload
{
    [self setTxtUsername:nil];
    [self setTxtPassword:nil];
    [self.txtUsername becomeFirstResponder];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) alertStatus:(NSString *)msg :(NSString *) title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
- (IBAction)loginClicked:(id)sender {
    
    // Build JSON Object first
    /***************************************************/
    // make the inner dictionaries (probably would use a for loop for this)
    NSDictionary *dict1 = [[NSDictionary alloc]
                           initWithObjectsAndKeys:[self.txtUsername text],@"email",
                           [self.txtPassword text],@"password",
                           nil];
    //NSDictionary *dict2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"password", @"test", nil];
    
    // put them in an array
    //NSArray *types = [[NSArray alloc] initWithObjects:dict1, dict2, nil];
    
    // now put the array in a dictionary
    NSDictionary *finalDict = [[NSDictionary alloc] initWithObjectsAndKeys:dict1, @"userData", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:finalDict options:0 error:&error];
    
    // Json string for debugging
//    NSString *jsonString = [[NSString alloc] init];
//    if (!jsonData) {
//        NSLog(@"Got an error: %@", error);
//    } else {
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    }
    
    /****************** Make the Post call for login ************************/
    NSURL *locationOfWebService = [NSURL URLWithString:@"http://localhost:8080/tracksafe/users/auth"];
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
        flag = 1;
        NSLog(@"Login SUCCESS");
        // This is custom segue call. This way segue only gets called when user enters correct username and password
        // We also have to make sure that we connect UI story board to next story board via ctrl-drag and not the login button.
        [self performSegueWithIdentifier:@"dashboard" sender:self];
    } else {
        if (error) NSLog(@"Login FAILURE: %@", error);
        [self alertStatus:@"Please cheack your credentials" :@"Login Failed!"];
    }
}

- (IBAction)backgroundClick:(id)sender {
    [self.txtUsername resignFirstResponder];
    [self.txtPassword resignFirstResponder];
}

// Sign Up
- (void)signUpMainViewControllerDidCancel: (TFSignUpMainViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"dashboard"] && flag == 1) {
        UINavigationController *navigationController = segue.destinationViewController;
        TFDashboardViewController *newActvitiyViewController = [[navigationController viewControllers] objectAtIndex:0];
    }
}

// facebook login
- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    [self.spinner stopAnimating];
}

- (IBAction)performLogin:(id)sender {
    [self.spinner startAnimating];
    
    TFAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}
@end
