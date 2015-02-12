//
//  VistedObject.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 9/13/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VistedObject : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, readonly, strong) NSMutableArray *visitedItems;
@property (nonatomic, readonly, strong) NSMutableArray *visitedItem;

@end
