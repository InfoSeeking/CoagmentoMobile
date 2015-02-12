//
//  MyCollaborators.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/14/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollaboratorName.h"
#import "CollaboratorItem.h"
@interface MyCollaborators : UITableViewController<NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    CollaboratorName *collabName;
    
    
}
@property (strong, nonatomic) id detailItem;
@property (nonatomic, strong) NSString *Key;

- (void)fetchEntries;
@end
