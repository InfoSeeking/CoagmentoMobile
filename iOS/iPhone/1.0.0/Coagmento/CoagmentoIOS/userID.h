//
//  userID.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/22/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userID : NSObject <NSXMLParserDelegate>{
    NSMutableString *currentString;
    
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *projectItemId;

@end
