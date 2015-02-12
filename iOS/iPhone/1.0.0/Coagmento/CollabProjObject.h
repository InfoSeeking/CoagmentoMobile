//
//  CollabProjObject.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/22/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollabProjObject : NSObject  <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *projectID;
@property (nonatomic, readonly, strong) NSMutableArray *collabprojItems;
@property (nonatomic, readonly, strong) NSMutableArray *collabprojItem;


@end
