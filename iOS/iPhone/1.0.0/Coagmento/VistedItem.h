//
//  VistedItem.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 9/13/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VistedItem : NSObject  <NSXMLParserDelegate>{
    NSMutableString *currentString;
    
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *visTitle;
@property (nonatomic, strong) NSString *visURL;
@property (nonatomic, strong) NSString *visTime;
@property (nonatomic, strong) NSString *visDate;
@property (nonatomic, strong) NSMutableArray *visteditem;


-(id)getURL;
-(id)getTitle;
-(id)getDate;
-(id)getTime;


@end

