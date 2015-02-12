//
//  CSpace.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/23/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "CSpace.h"
#import "SignInVC.h"

@implementation CSpace

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //here we pass the USERID num to the next controller
    [self setKey:_Key];
    ProjectsTVC *dest = (ProjectsTVC *)[segue destinationViewController];
    dest.Key = [self Key];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
