//
//  ID.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/23/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignIn.h"

@interface ID : NSObject{

}
@property (nonatomic, strong) NSString *userIDnumber;


-(id)initWithName:(NSString *)userIDnumber;
@end
