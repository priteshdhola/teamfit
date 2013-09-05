//
//  TFDashboardViewController.m
//  TeamFit
//
//  Created by pritesh patel on 9/2/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "TFDashboardViewController.h"
#import "Activity.h"
#import "TFActivityCell.h"
#import "TFOpenActivityViewController.h"

@interface TFDashboardViewController ()

@end

@implementation TFDashboardViewController {
    NSMutableArray *activities;
}
@synthesize activities;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    activities = [NSMutableArray arrayWithCapacity:20];
	Activity *activity = [[Activity alloc] init];
	activity.name = @"Morning Group Run";
	activity.date = @"05/06/2013";
    activity.time = @"8:30 AM";

	[activities addObject:activity];
	activity = [[Activity alloc] init];
	activity.name = @"Local Solo Run";
	activity.date = @"06/07/2013";
    activity.time = @"8:00 AM";

	[activities addObject:activity];
	activity = [[Activity alloc] init];
	activity.name = @"Marathon Day";
	activity.date = @"07/08/2013";
    activity.time = @"8:00 AM";

	[activities addObject:activity];

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
	return [self.activities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    TFActivityCell *cell = (TFActivityCell *)[tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
	Activity *activity = [self.activities objectAtIndex:indexPath.row];
	cell.nameLabel.text = activity.name;
	cell.dateLabel.text = activity.date;
    cell.timeLabel.text = activity.time;

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[self.activities removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

//////////////////////////////////////////////////////////////////////////

// Create an activity
- (void)newActivityViewControllerDidCancel: (TFNewActivityViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)newActivityViewController: (TFNewActivityViewController *)controller didAddActivity:(Activity *)activity
{
	[self.activities addObject:activity];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.activities count] - 1 inSection:0];
	[self.tableView insertRowsAtIndexPaths:
     [NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	[self dismissViewControllerAnimated:YES completion:nil];
}


// Open an activity 
- (void)openActivityViewControllerDidCancel: (TFOpenActivityViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openActivityViewControllerDidStart: (TFOpenActivityViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}


// Segue logic
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{        
    if ([segue.identifier isEqualToString:@"AddActivity"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        TFNewActivityViewController *newActvitiyViewController = [[navigationController viewControllers] objectAtIndex:0];
        newActvitiyViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"OpenActivity"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        TFOpenActivityViewController *openActvitiyViewController = [[navigationController viewControllers] objectAtIndex:0];
        openActvitiyViewController.openActivityNameTextLabel.text = @"TEMP";
        openActvitiyViewController.openActivityDateTextLabel.text = @"TEMP";
        openActvitiyViewController.openActivityTimeTextLabel.text = @"TEMP";
        openActvitiyViewController.delegate = self;
    }
}
@end
