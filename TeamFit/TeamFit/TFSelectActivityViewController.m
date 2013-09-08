//
//  TFSelectActivityViewController.m
//  TeamFit
//
//  Created by pritesh patel on 9/7/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "TFSelectActivityViewController.h"

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

// Segue logic
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"StartingActivity"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        TFNewActivityViewController *newActvitiyViewController = [[navigationController viewControllers] objectAtIndex:0];
        newActvitiyViewController.delegate = self;
    }
}

@end
