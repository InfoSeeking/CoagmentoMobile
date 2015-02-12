//
//  CoagmentoViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/16/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectObject.h"
#import "projectItem.h"
#import "CollaboratorName.h"
#import "CollaboratorItem.h"


@interface CoagmentoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate, UIActionSheetDelegate>
{
    NSURLConnection *connection;
    NSMutableArray *dataArray;
    NSMutableArray *projectsDataArray;
    NSMutableArray *collabDataArray;
    NSMutableData *xmlData;
    ProjectObject *project;
    CollaboratorName *collaborators;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Logout;
@property (nonatomic, weak) NSString *userIDnum;
@property (nonatomic, copy) NSString *Key;
@property (nonatomic, weak) projectItem *pItem;
@property (nonatomic, weak) CollaboratorItem *cItem;
@property (nonatomic, retain) NSMutableArray *arrayProjectsURL;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (nonatomic, weak) IBOutlet UITableView *table;
@property (nonatomic, weak) IBOutlet UITableView *table2;

-(id)getKey;


- (id)copyWithZone:(NSZone *)zone;

//ADD AND MUTABLE ARRAY TO HOLD A LIST TO POPULATE TABLE VIEW WITH
- (void)fetchEntries;


@end
