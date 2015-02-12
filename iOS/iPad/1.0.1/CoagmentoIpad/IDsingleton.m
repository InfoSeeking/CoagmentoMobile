//
//  IDsingleton.m
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/22/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "IDsingleton.h"

@implementation IDsingleton
{
    IDsingleton *singleton;
}
@synthesize IDstring;

+ (IDsingleton *)userID{
    
    static IDsingleton *userID = nil;
    if (!userID)
        userID = [[super allocWithZone:nil]init];
        return userID;
}

+ (id)allocWithZone:(NSZone *)zone{
    return [self userID];
}

-(id)initWithString:(NSString *)string{
    self = [super init];
    if (self) {
        IDstring = [[NSString alloc]initWithString:string];
    }
    return self;
}



- (void)setID:(NSString *)string{
    
    IDstring = string;
    
}

- (NSString *)IDstring{
    return IDstring;
}

@end
