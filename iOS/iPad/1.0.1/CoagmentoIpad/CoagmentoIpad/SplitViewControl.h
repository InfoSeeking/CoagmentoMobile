//
//  SplitViewControl.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignIn.h"

@protocol SplitViewControllerDelegate
@optional


@end

@interface SplitViewControl : UISplitViewController

@property (nonatomic, assign) BOOL signedIn;
@property (nonatomic, assign) BOOL loggedOff;
@property (nonatomic, assign) BOOL loadViewOK;
@property (nonatomic, weak) NSString *userIDnumbero;
@property (nonatomic, weak) UIStoryboard *storyboard;
@property (nonatomic, weak) SignIn * signIn;
@property (nonatomic, weak) SignIn * signIn2;
@property (nonatomic, weak) NSArray *myVCS;
-(void)logOuttt;
-(void)clearCMVC;



@end
