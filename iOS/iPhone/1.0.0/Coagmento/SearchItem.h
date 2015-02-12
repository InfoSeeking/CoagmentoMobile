//
//  SearchItem.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchItem : NSObject  <NSXMLParserDelegate>{
    NSMutableString *currentString;
    
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *searchQuery;
@property (nonatomic, strong) NSString *searchUrl;
@property (nonatomic, strong) NSString *searchDate;
@property (nonatomic, strong) NSString *searchSource;
@property (nonatomic, strong) NSMutableArray *searchitem;


-(id)getQuery;
-(id)getURL;
-(id)getDate;
-(id)getSource;



@end
