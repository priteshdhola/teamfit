//
//  TFNewActivityViewController.m
//  TeamFit
//
//  Created by pritesh patel on 9/2/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "TFNewActivityViewController.h"
#import "Activity.h"


@interface TFNewActivityViewController ()

@end

@implementation TFNewActivityViewController
@synthesize delegate;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		[self.activityNameTextField becomeFirstResponder];
    }
    if (indexPath.section == 0) {
		[self.activityDateTextField becomeFirstResponder];
    }
    if (indexPath.section == 0) {
		[self.activityTimeTextField becomeFirstResponder];
    }
    if (indexPath.section == 0) {
		[self.activityMembersTextField becomeFirstResponder];
    }
}

/////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)cancel:(id)sender
{
	[self.delegate newActivityViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
    Activity *activity = [[Activity alloc] init];
	activity.name = self.activityNameTextField.text;
	activity.date = self.activityDateTextField.text;;
    activity.time = self.activityTimeTextField.text;;
	//activity.friends = self.activityMembersTextField.text;;

	[self.delegate newActivityViewController:self didAddActivity:activity];    
}

@end
