//
//  MembersObject.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MembersItem.h"
#import "MembersObject.h"

@interface MembersObject : NSObject  <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *MemberName;
@property (nonatomic, strong) NSString *MemberID;

@property (nonatomic, readonly, strong) NSMutableArray *membersItems;
@property (nonatomic, readonly, strong) NSMutableArray *membersItem;


@end
