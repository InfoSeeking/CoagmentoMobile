//
//  BookmarkedCollectionCell.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 11/3/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookmarkedCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *BookmarkIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *URL;
@property (weak, nonatomic) IBOutlet UILabel *Date;
@property (weak, nonatomic) IBOutlet UILabel *Time;

@end
