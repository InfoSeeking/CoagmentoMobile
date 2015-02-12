//
//  CoagmentoMasterViewController.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/8/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignIn.h"
#import "MasterDetailProtocol.h"
#import "PassDataDelegate.h"
#import "ProjectObject.h"
#import "projectItem.h"
#import "CollaboratorName.h"
#import "CollaboratorItem.h"


@class CoagmentoViewController;

@interface CoagmentoMasterViewController : UITableViewController < PassDataDelegate, NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableArray *dataArray;
    NSMutableArray *projectsDataArray;
    NSMutableArray *collabDataArray;
    NSMutableData *xmlData;
    ProjectObject *project;
    CollaboratorName *collaborators;
    
}



@property (strong, nonatomic) CoagmentoViewController *detailViewController;
@property (nonatomic, weak) NSString *userIDnumero;
@property (nonatomic, weak) IBOutlet UITableView *table;
@property (weak, nonatomic) id <MasterDetailProtocol> delegate;
@property (nonatomic, copy) NSMutableArray *CSpaceCacheImagesArray;

-(void)setDetail:(NSString *)detail;
-(void)unloadTableData;
-(id)getUserID;
- (void)fetchEntries;




@end
