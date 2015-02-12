//
//  CSpaceItem.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 10/9/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSpaceItem : NSObject  <NSXMLParserDelegate>{
    NSMutableString *currentString;
    
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *csTitle;
@property (nonatomic, strong) NSString *csURL;
@property (nonatomic, strong) NSString *csTime;
@property (nonatomic, strong) NSString *csDate;
@property (nonatomic, strong) NSString *csType;
@property (nonatomic, strong) NSString *csBookmark;
@property (nonatomic, strong) NSString *csThumbnail;
@property (nonatomic, strong) NSMutableArray *cspaceitem;


-(id)getURL;
-(id)getTitle;
-(id)getDate;
-(id)getTime;
-(id)getThumbnail;
-(id)getBookmark;
-(id)getType;



@end
