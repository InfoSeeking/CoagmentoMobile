//
//  ProjectsTVC.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/16/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectObject.h"

@interface ProjectsTVC : UITableViewController <NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    ProjectObject *project;
    
}

@property (nonatomic, readonly, strong) NSMutableArray *projNames;
- (void)fetchEntries;
@end

