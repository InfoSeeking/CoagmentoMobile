//
//  MySnippetsViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/15/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnippetObject.h"
#import "SnippetItem.h"
#import "AnnotationObject.h"
#import "AnnotationItem.h"
#import "DetailViewController.h"
#import "tabBarItem.h"

@interface MySnippetsViewController : UIViewController <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    SnippetObject *snippet;
    AnnotationObject *annotation;
    DetailViewController *detail;
    tabBarItem *tabBarItem;
    
    
    
}
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;
@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;

-(id)getProjTitle;
-(id)getProjID;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;



//-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;
@end



