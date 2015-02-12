//
//  IDsingleton.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/22/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDsingleton : NSObject
{
    NSString *IDstring;
    NSMutableArray *allItems;
}
+ (IDsingleton *)userID;

@property (nonatomic) NSString *IDstring;


-(NSString *) IDstring;
- (void)setID:(NSString *)string;

//-(NSArray *)allItems;

@end
