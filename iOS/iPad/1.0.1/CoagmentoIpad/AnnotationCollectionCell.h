//
//  AnnotationCollectionCell.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 11/5/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnotationCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *URL;
@property (weak, nonatomic) IBOutlet UILabel *Date;
@property (weak, nonatomic) IBOutlet UILabel *Time;
@property (weak, nonatomic) IBOutlet UIImageView *Icon;

@end
