//
//  AnnotationItem.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnotationItem : NSObject <NSXMLParserDelegate>{
    NSMutableString *currentString;
    
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *annotationTitle;
@property (nonatomic, strong) NSString *annotationUrl;
@property (nonatomic, strong) NSString *annotationDate;
@property (nonatomic, strong) NSString *annotationTime;


@property (nonatomic, strong) NSMutableArray *annotationitem;


-(id)getDate;
-(id)getTitle;
-(id)getURL;
-(id)getTime;


@end
