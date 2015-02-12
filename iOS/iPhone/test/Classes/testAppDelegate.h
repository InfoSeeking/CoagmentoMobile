//
//  testAppDelegate.h
//  test
//
//  Created by Chirag Shah on 8/31/11.
//  Copyright School of Communication & Information (SC&I), Rutgers University 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class testViewController;

@interface testAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet testViewController *viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) testViewController *viewController;

@end

