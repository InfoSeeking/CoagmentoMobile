//
//  ProjectObject.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/16/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectObject : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}
@property (nonatomic, strong) id parentParserDelegate;

@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *projectID;
@property (nonatomic, readonly, strong) NSMutableArray *projNames;
@property (nonatomic, readonly, strong) NSMutableArray *IDs;


@end
