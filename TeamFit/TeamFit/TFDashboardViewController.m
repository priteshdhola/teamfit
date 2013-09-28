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
#import "TFSelectActivityViewController.h"

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
    NSString* serverAddress = @"http://localhost:8080/tracksafe/activities";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
        
    NSData *apiResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    ///////////////////////// MAKING THE GET REQUEST AND PARSING THE DATA /////////////////////////////
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:apiResponse options:kNilOptions error:&error];
    NSDictionary* allData = [json objectForKey:@"activityDataList"];
    NSArray* allActivities = [allData objectForKey:@"activityData"];
    
    NSDictionary* jsonActivity;
    NSString* name;
    NSString* type;
    NSString* dateAndTime;
    NSArray* foo;
    NSString* dateValue;
    NSString* timeValue;
    Activity *activity;
    
    for (int i = 0; i < [allActivities count]; i++)
    {
        jsonActivity = [allActivities objectAtIndex:i];
        
        name = [jsonActivity objectForKey:@"name"];
        type = [jsonActivity objectForKey:@"type"];
        dateAndTime = [jsonActivity objectForKey:@"createdDate"];
        foo = [dateAndTime componentsSeparatedByString: @"T"];
        dateValue = [foo objectAtIndex: 0];
        timeValue = [foo objectAtIndex: 1];
        foo = [timeValue componentsSeparatedByString: @"-"];
        timeValue = [foo objectAtIndex: 0];
        
        activity = [[Activity alloc] init];
        activity.name = name;
        activity.date = dateValue;
        activity.time = timeValue;
        [activities addObject:activity];
    }
    self.navigationController.navigationBar.barTintColor  = [UIColor blackColor];

    
    /******************************* HARD CODED DATA *******************************/
    
//	activity = [[Activity alloc] init];
//	activity.name = @"Morning Group Run";
//	activity.date = @"05/06/2013";
//    activity.time = @"8:30 AM";
//	[activities addObject:activity];
//    
//	activity = [[Activity alloc] init];
//	activity.name = @"Local Solo Run";
//	activity.date = @"06/07/2013";
//    activity.time = @"8:00 AM";
//	[activities addObject:activity];
//    
//	activity = [[Activity alloc] init];
//	activity.name = @"Marathon Day";
//	activity.date = @"07/08/2013";
//    activity.time = @"8:00 AM";
//	[activities addObject:activity];
    
    /********************************************************************************/
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
    NSLog(@"%lu",(unsigned long)[activities count]);
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
    [self performSegueWithIdentifier:@"OpenActivity" sender:self];
}

/********************************************************************************/

// Create an activity
- (void)newActivityViewControllerDidCancel: (TFNewActivityViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

/******************************** HARD CODED ADD ACTIVITY ***********************/
//- (void)newActivityViewController: (TFNewActivityViewController *)controller didAddActivity:(Activity *)activity
//{
//	[self.activities addObject:activity];
//	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.activities count] - 1 inSection:0];
//	[self.tableView insertRowsAtIndexPaths:
//     [NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//	[self dismissViewControllerAnimated:YES completion:nil];
//}
/********************************************************************************/


/******************************** POST REQUEST TO CREATE ACTIVITY ***********************/
- (void)newActivityViewController: (TFNewActivityViewController *)controller didAddActivity:(Activity *)activity
{
    NSString *soapFormat = [NSString stringWithFormat:@"{\"activityData\": {\"name\": \"%@\",\"type\": \"1\",\"startDate\": \"%@ %@\"}}",activity.name,activity.date,activity.time];
    
    NSLog(@"The request format is %@",soapFormat);
    NSURL *locationOfWebService = [NSURL URLWithString:@"http://localhost:8080/tracksafe/activities"];
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
        
	[self.activities addObject:activity];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.activities count] - 1 inSection:0];
	[self.tableView insertRowsAtIndexPaths:
     [NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	[self dismissViewControllerAnimated:YES completion:nil];
}



// Open an activity 
- (void)selectActivityViewControllerDidCancel: (TFSelectActivityViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectActivityViewControllerDidStart: (TFSelectActivityViewController *)controller
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
        TFSelectActivityViewController *openActvitiyViewController = [[navigationController viewControllers] objectAtIndex:0];
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        openActvitiyViewController.myActivity = [activities objectAtIndex:selectedRowIndex.row];
        openActvitiyViewController.delegate = self;
    }
}
@end
