//
//  CollabProjItem.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/22/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollabProjItem : NSObject <NSXMLParserDelegate>{
    NSMutableString *currentString;
    
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *projectItemId;
@property (nonatomic, strong) NSString *projectItemName;
@property (nonatomic, strong) NSMutableArray *collabprojectitem;


-(id)getID;
-(id)getTitle;


@end
