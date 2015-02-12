//
//  CSpacePopup.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/28/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSpacePopup : UIViewController
@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Date;
@property (weak, nonatomic) IBOutlet UILabel *Time;
@property (weak, nonatomic) IBOutlet UILabel *Type;
@property (weak, nonatomic) IBOutlet UILabel *URL;


//-(void)setDetail:(NSMutableArray *)detail;
@end
