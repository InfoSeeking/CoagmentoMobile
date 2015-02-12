//
//  MyBookmarksViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/23/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarControl.h"
#import "BookmarkItem.h"
#import "BookmarkObject.h"
#import "VistedItem.h"
#import "VistedObject.h"


@interface MyBookmarksViewController : UIViewController <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    BookmarkObject *bookmark;
    VistedObject *visited;
    
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;

@property (strong, nonatomic) id detailItem;
@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;


-(id)getProjTitle;
-(id)getProjID;


//-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;


@end
