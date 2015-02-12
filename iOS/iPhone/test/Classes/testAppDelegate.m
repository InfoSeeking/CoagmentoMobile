//
//  testAppDelegate.m
//  test
//
//  Created by Chirag Shah on 8/31/11.
//  Copyright School of Communication & Information (SC&I), Rutgers University 2011. All rights reserved.
//

#import "testAppDelegate.h"
#import "testViewController.h"

@implementation testAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	// Override point for customization after app launch	
    [window addSubview:viewController.view];
	[window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
	[window release];
	[super dealloc];
}


@end
