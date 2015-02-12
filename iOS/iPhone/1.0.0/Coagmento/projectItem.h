//
//  projectItem.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/17/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface projectItem : NSObject <NSXMLParserDelegate>{
    NSMutableString *currentString;
    
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *projectItemId;
@property (nonatomic, strong) NSString *projectItemName;
@property (nonatomic, strong) NSMutableArray *projectitem;


-(id)getID;
-(id)getTitle;


@end
