//
//  TFAppDelegate.m
//  TeamFit
//
//  Created by pritesh patel on 9/2/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "TFAppDelegate.h"
#import "Activity.h"
#import "TFDashboardViewController.h"

@implementation TFAppDelegate
//{
//    NSMutableArray *activities;
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//	activities = [NSMutableArray arrayWithCapacity:20];
//	Activity *activity = [[Activity alloc] init];
//	activity.name = @"Bill Evans";
//	activity.date = @"05/06/2013";
//	[activities addObject:activity];
//	activity = [[Activity alloc] init];
//	activity.name = @"Oscar Peterson";
//	activity.date = @"06/07/2013";
//	[activities addObject:activity];
//	activity = [[Activity alloc] init];
//	activity.name = @"Dave Brubeck";
//	activity.date = @"07/08/2013";
//	[activities addObject:activity];
//    
//	//UITabBarController *navigationController = (UITabBarController *)self.window.rootViewController;
//    UIViewController *tabBarController = (UIViewController *)self.window.rootViewController;
//    
//    UINavigationController *navigationController = [[tabBarController viewControllers] objectAtIndex:0];
//	TFDashboardViewController *activitiesViewController = [[navigationController viewControllers] objectAtIndex:0];
//	activitiesViewController.activities = activities;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
