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


@property (nonatomic, strong) NSString *Key;
@property (nonatomic, copy) NSString *UserID;
@property (nonatomic, copy) NSString *Collaboratorname;
//@property (nonatomic, copy) NSString *Organization;
//@property (nonatomic, copy) NSString *Email;
//@property (nonatomic, copy) NSString *Website;
//@property (nonatomic, copy) NSString *Avatar;


-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;
//-(id)getOrganization;
//-(id)getUserID;
//-(id)getEmail;
//-(id)getAvatar;
//-(id)getProjTitle;
//-(id)getProjID;
//-(id)getKey;


@end
