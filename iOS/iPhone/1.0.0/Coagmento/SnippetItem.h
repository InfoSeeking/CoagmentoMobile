//
//  SnippetItem.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/15/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SnippetItem : NSObject <NSXMLParserDelegate>{
    NSMutableString *currentString;
    
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *snipTitle;
@property (nonatomic, strong) NSString *snipUrl;
@property (nonatomic, strong) NSString *snipDate;
@property (nonatomic, strong) NSString *snipContent;
@property (nonatomic, strong) NSString *snipNote;
@property (nonatomic, strong) NSMutableArray *snippetitem;


-(id)getDate;
-(id)getTitle;
-(id)getContent;
-(id)getURL;
-(id)getNote;


@end
