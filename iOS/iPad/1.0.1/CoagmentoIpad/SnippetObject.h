//
//  SnippetObject.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/15/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SnippetObject : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *snippetTitle;
@property (nonatomic, strong) NSString *snippetURL;
@property (nonatomic, strong) NSString *snippetContent;
@property (nonatomic, strong) NSString *snippetDate;
@property (nonatomic, strong) NSString *snippetNote;
@property (nonatomic, readonly, strong) NSMutableArray *snipItems;
@property (nonatomic, readonly, strong) NSMutableArray *snipItem;


@end