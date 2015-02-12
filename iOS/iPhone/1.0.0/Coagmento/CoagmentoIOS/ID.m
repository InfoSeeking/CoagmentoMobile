//
//  ID.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/23/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "ID.h"
#import "SignInVC.h"

@implementation ID


-(id)initWithName:(NSString *)userIDnumber{
    
    
    self = [super init];
    if (self) {
        self.userIDnumber = [[NSString alloc]init];
        _userIDnumber = userIDnumber;
        return self;
    }
    return nil;
}

- (void)setUserIDnumber:(NSString *)userIDnumber{
    if (_userIDnumber != userIDnumber) {
        _userIDnumber = userIDnumber;
    }
}

-(id)copyWithZone:(NSZone *)zone{
    return self;
}

@end
