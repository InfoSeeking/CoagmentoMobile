//
//  SnippetCollectionCell.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 11/5/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnippetCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Icon;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *URL;
@property (weak, nonatomic) IBOutlet UILabel *Date;
@property (weak, nonatomic) IBOutlet UILabel *Note;
@property (weak, nonatomic) IBOutlet UITextView *Content;

@end
