//
//  TabBarControl.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/22/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnnotations.h"
#import "MyCSpaceViewController.h"
#import "MyMembersViewController.h"
#import "MySearchesViewController.h"
#import "MySnippetsViewController.h"
#import "MyWebpagesVC.h"



@interface TabBarControl : UITabBarController
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    
}

@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

//- (void)fetchEntries;

@property (nonatomic, weak) NSString *userIDnum;
@property (nonatomic, copy) NSString *Key;
@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;
@property(nonatomic, assign) MySnippetsViewController *mysnippets;
@property(nonatomic, assign) MySearchesViewController *mysearches;
@property(nonatomic, assign) MyAnnotations *myannotations;
@property(nonatomic, assign) MyWebpagesVC *mywebpages;
@property(nonatomic, assign) MyCSpaceViewController *mycspace;
@property(nonatomic, assign) MyMembersViewController *mymembers;






//-(id)getKey;
-(id)getProjTitle;
-(id)getProjID;
//- (id)copyWithZone:(NSZone *)zone;
-(void)setDetail:(NSMutableArray *)detail;


@end
