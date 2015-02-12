//
//  CollaboratorName.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/14/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollaboratorItem.h"

@interface CollaboratorName : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *collaboratorName;
@property (nonatomic, strong) NSString *collaboratorID;
@property (nonatomic, readonly, strong) NSMutableArray *collabItems;


@end
