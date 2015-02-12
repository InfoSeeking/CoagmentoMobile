//
//  UserViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 9/24/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObject.h"
#import "UserItem.h"


@interface UserViewController : UIViewController <NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    UserObject *user;
    
    
}
@property (weak, nonatomic) IBOutlet UILabel *Namee;
@property (weak, nonatomic) IBOutlet UILabel *Emaill;
@property (weak, nonatomic) IBOutlet UILabel *Organizationn;
@property (weak, nonatomic) IBOutlet UILabel *Websitee;
@property (weak, nonatomic) IBOutlet UIImageView *Avatarr;



@property (strong, nonatomic) id detailItem;
@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;
@property (nonatomic, strong) NSString *Key;
@property (nonatomic, copy) NSString *UserID;
@property (nonatomic, copy) NSString *Collaboratorname;

-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;


@end
