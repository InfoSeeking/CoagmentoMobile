//
//  CSpaceObject.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 10/9/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSpaceItem.h"

@interface CSpaceObject : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *bookmark;
@property (nonatomic, readonly, strong) NSMutableArray *cspaceItems;
@property (nonatomic, readonly, strong) NSMutableArray *cspaceItem;

@end
