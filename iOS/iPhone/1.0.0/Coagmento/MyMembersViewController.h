//
//  MyMembersViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollabProjItem.h"
#import "CollabProjObject.h"
#import "MembersObject.h"
#import "MembersItem.h"

@interface MyMembersViewController : UIViewController <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    MembersObject *member;
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) id detailItem;
@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;
@property (nonatomic, copy) NSString *UserID;


-(id)getProjTitle;
-(id)getProjID;
-(id)getUserID;


-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;

@end
