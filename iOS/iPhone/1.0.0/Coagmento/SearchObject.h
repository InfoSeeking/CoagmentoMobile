//
//  SearchObject.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchObject : NSObject  <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *SearchQuery;
@property (nonatomic, strong) NSString *SearchURL;
@property (nonatomic, strong) NSString *SearchDate;
@property (nonatomic, strong) NSString *SearchSource;
@property (nonatomic, readonly, strong) NSMutableArray *searItems;
@property (nonatomic, readonly, strong) NSMutableArray *searItem;

@end
