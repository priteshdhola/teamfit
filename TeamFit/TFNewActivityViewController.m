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
@synthesize datePicker;
@synthesize dateValue;
@synthesize timeValue;
@synthesize dateandtime;
@synthesize activityDateTextField;

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
    self.navigationController.navigationBar.barTintColor  = [UIColor blackColor];
    activityDateTextField.delegate = self;
    
    datePicker = [[UIDatePicker alloc]init];
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    datePicker.minuteInterval = 15;
    self.activityDateTextField.inputView = datePicker;
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
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    dateandtime = [datePicker date];
    
    [format setDateFormat:@"MM/dd/yyyy"];
    dateValue = [format stringFromDate:dateandtime];
//    NSLog(@"%@",dateValue);
    
//    [format setDateFormat:@"hh:mm a"];
    [format setDateFormat:@"hh:mm"];
    timeValue = [format stringFromDate:dateandtime];
//    NSLog(@"%@",timeValue);
    self.activityDateTextField.text = dateValue;
    
    Activity *activity = [[Activity alloc] init];
	activity.name = self.activityNameTextField.text;
    activity.date = dateValue;
    activity.time = timeValue;
//    activity.friends = self.activityMembersTextField.text;

//	activity.date = self.activityDateTextField.text;;
//    activity.time = self.activityTimeTextField.text;;
    
	[self.delegate newActivityViewController:self didAddActivity:activity];    
}

- (IBAction)dateChanged:(id)sender {
    datePicker = (UIDatePicker *)sender;
    self.activityDateTextField.text = [NSString stringWithFormat:@"%@", datePicker.date];
    [activityDateTextField resignFirstResponder];
}
- (IBAction)doneEditing:(id)sender {
    [self.activityDateTextField resignFirstResponder];
    //[textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.activityDateTextField) {
        [theTextField resignFirstResponder];        
    }
    return YES;
}

@end
