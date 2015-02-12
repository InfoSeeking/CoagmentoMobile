//
//  MembersCollectionCell.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/30/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MembersCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *MemberImage;
@property (weak, nonatomic) IBOutlet UILabel *memberName;
@property (weak, nonatomic) IBOutlet UILabel *memberEmail;
@property (weak, nonatomic) IBOutlet UILabel *memberOrg;

@end
