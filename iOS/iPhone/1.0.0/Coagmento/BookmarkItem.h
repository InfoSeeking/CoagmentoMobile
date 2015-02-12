//
//  BookmarkItem.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/15/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookmarkItem : NSObject <NSXMLParserDelegate>{
    NSMutableString *currentString;
    
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *bmTitle;
@property (nonatomic, strong) NSString *bmURL;
@property (nonatomic, strong) NSString *bmTime;
@property (nonatomic, strong) NSString *bmDate;
@property (nonatomic, strong) NSMutableArray *bookmarkitem;


-(id)getURL;
-(id)getTitle;
-(id)getDate;
-(id)getTime;


@end
