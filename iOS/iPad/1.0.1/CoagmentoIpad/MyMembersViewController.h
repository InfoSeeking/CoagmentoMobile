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
#import "MembersCollection.h"

#import "UserObject.h"
#import "UserItem.h"

@interface MyMembersViewController : UIViewController <NSXMLParserDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    

    
    MembersObject *member;
    
    UserObject *user;
    
    
}

@property (weak, nonatomic) IBOutlet MembersCollection *MemberCollection;


@property (strong, nonatomic) id detailItem;
@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;
@property (nonatomic, copy) NSString *UserID;


@property (weak, nonatomic) IBOutlet UILabel *Namee;
@property (weak, nonatomic) IBOutlet UILabel *Emaill;
@property (weak, nonatomic) IBOutlet UILabel *Organizationn;
@property (weak, nonatomic) IBOutlet UILabel *Websitee;
@property (weak, nonatomic) IBOutlet UIImageView *Avatarr;

-(id)getProjTitle;
-(id)getProjID;
-(id)getUserID;


//-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;

@end
