//
//  MasterDetailProtocol.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MasterDetailProtocol <NSObject>

-(void)masterAction:(id)sender;
-(NSString *)getMeTheID;

@end
