//
//  TFSelectActivityViewController.m
//  TeamFit
//
//  Created by pritesh patel on 9/7/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "TFSelectActivityViewController.h"
#import "TFRunningActivityViewController.h"

@interface TFSelectActivityViewController ()

@end

@implementation TFSelectActivityViewController

@synthesize myActivity;
@synthesize delegate;
@synthesize selectActivityNameTextBox;
@synthesize selectActivityDateTextBox;
@synthesize selectActivityTimeTextBox;
@synthesize selectActivityMembersTextBox;

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
    self.selectActivityNameTextBox.text = myActivity.name;
    self.selectActivityDateTextBox.text = myActivity.date;
    self.selectActivityTimeTextBox.text = myActivity.time;
    self.navigationController.navigationBar.tintColor  = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)cancel:(id)sender
{
	[self.delegate selectActivityViewControllerDidCancel:self];
}

//- (IBAction)start:(id)sender
//{
//    [self.delegate selectActivityViewControllerDidStart:self];
//}

- (void)runningActivityViewControllerDidEnd: (TFRunningActivityViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

// Segue logic
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"StartingActivity"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        TFRunningActivityViewController *runningActvitiyViewController = [[navigationController viewControllers] objectAtIndex:0];
        runningActvitiyViewController.delegate = self;
    }
}

@end
