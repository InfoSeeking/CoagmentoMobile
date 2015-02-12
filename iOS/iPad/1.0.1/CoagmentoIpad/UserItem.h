//
//  UserItem.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 9/23/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserItem : NSObject  <NSXMLParserDelegate>{
    NSMutableString *currentString;
    
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userAvatar;
@property (nonatomic, strong) NSString *userOrganization;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *userWebsite;
@property (nonatomic, strong) NSMutableArray *useritem;


-(id)getID;
-(id)getName;
-(id)getAvatar;
-(id)getOrganization;
-(id)getEmail;
-(id)getWebsite;

@end
