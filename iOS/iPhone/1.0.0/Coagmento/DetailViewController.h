//
//  DetailViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/24/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDate;
@property (weak, nonatomic) IBOutlet UILabel *detailNote;
@property (weak, nonatomic) IBOutlet UITextView *detailTitle;
@property (weak, nonatomic) IBOutlet UITextView *detailDescriptionLabel;


@end
