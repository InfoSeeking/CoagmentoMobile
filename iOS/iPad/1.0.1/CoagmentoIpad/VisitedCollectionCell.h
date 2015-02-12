//
//  VisitedCollectionCell.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/31/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitedCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *VisitedIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *URL;
@property (weak, nonatomic) IBOutlet UILabel *Date;
@property (weak, nonatomic) IBOutlet UILabel *Time;

@end
