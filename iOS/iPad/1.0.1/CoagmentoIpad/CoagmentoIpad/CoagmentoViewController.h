//
//  CoagmentoViewController.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/8/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "ProjectObject.h"
#import "projectItem.h"
#import "CollaboratorName.h"
#import "CollaboratorItem.h"
#import "SignIn.h"
#import "MasterDetailProtocol.h"
#import "PassDataDelegate.h"
#import "MyAnnotations.h"
#import "MyCSpaceViewController.h"
#import "MyMembersViewController.h"
#import "MySearchesViewController.h"
#import "MySnippetsViewController.h"
#import "MyWebpagesVC.h"
#import "SplitViewControl.h"





@interface CoagmentoViewController : UITabBarController <UISplitViewControllerDelegate, NSXMLParserDelegate, MasterDetailProtocol, SplitViewControllerDelegate, UIActionSheetDelegate>
{
    NSURLConnection *connection;
    NSMutableArray *dataArray;
    NSMutableArray *projectsDataArray;
    NSMutableArray *collabDataArray;
    NSMutableData *xmlData;
    ProjectObject *project;
    CollaboratorName *collaborators;
   

}

@property (weak, nonatomic) id <PassDataDelegate> myDelegatee;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, weak) NSString *userIDnum;
@property (nonatomic, copy) NSString *Key;
@property (nonatomic, weak) projectItem *pItem;
@property (nonatomic, weak) CollaboratorItem *cItem;
@property (nonatomic, retain) NSMutableArray *arrayProjectsURL;
@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;
@property(nonatomic, assign) MySnippetsViewController *mysnippets;
@property(nonatomic, assign) MySearchesViewController *mysearches;
@property(nonatomic, assign) MyAnnotations *myannotations;
@property(nonatomic, assign) MyWebpagesVC *mywebpages;
@property(nonatomic, assign) MyCSpaceViewController *mycspace;
@property(nonatomic, assign) MyMembersViewController *mymembers;
@property (nonatomic, weak) UIStoryboard *storyboard;
@property (nonatomic, weak) SignIn * signIn;


-(id)getProjTitle;
-(id)getProjID;
//-(id)getKey;
-(id)getUserID;
//- (id)copyWithZone:(NSZone *)zone;
-(void)setDetail:(NSMutableArray *)detail;
-(void)setCSpaceImages:(NSMutableArray *) images;

-(void)passDataToTabs;
@end

