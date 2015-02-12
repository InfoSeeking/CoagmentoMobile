//
//  MyCSpaceViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSpaceItem.h"
#import "CSpaceObject.h"

@interface MyCSpaceViewController : UIViewController  <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    CSpaceObject *cspace;
    
    
}
@property (strong, nonatomic) id detailItem;
@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;
@property (nonatomic, copy) NSString *UserID;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(id)getProjTitle;
-(id)getProjID;
-(id)getUserID;

//-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;



@end
