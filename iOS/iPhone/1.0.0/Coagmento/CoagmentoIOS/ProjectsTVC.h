//
//  ProjectsTVC.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/16/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectObject.h"
#import "projectItem.h"
#import "CollabProjItem.h"
#import "CollabProjObject.h"

@interface ProjectsTVC : UITableViewController <NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    CollabProjObject *project;
    
    
}
@property (nonatomic, strong) NSString *Key;
@property (nonatomic, copy) NSString *CollaboratorID;
@property (nonatomic, copy) NSString *Collaboratorname;
@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;


-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;
-(id)getProjTitle;
-(id)getProjID;
-(id)getKey;

@end

