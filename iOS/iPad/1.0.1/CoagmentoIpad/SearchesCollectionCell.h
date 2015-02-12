//
//  SearchesCollectionCell.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/30/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchesCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *SearchIcon;
@property (weak, nonatomic) IBOutlet UILabel *Query;
@property (weak, nonatomic) IBOutlet UILabel *Date;


@end
