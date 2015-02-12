//
//  CollaboratorItem.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/14/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollaboratorItem : NSObject <NSXMLParserDelegate>{
    NSMutableString *currentString;
    
}
@property (nonatomic, strong) id parentParserDelegate;
@property (nonatomic, strong) NSString *collaboratorItemId;
@property (nonatomic, strong) NSString *collaboratorItemName;



-(id)getID;
-(id)getTitle;


@end
