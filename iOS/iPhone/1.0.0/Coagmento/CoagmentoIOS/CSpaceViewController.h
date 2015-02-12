//
//  CSpaceViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/15/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CSpaceViewController : UIViewController
- (IBAction)CSpaceAll:(id)sender;
- (IBAction)Bookmarks:(id)sender;
- (IBAction)Snippets:(id)sender;
- (IBAction)Webpages:(id)sender;
- (IBAction)Annotations:(id)sender;
- (IBAction)Searches:(id)sender;


@property (nonatomic, strong) NSString *Key;
@property (nonatomic, strong) NSString *ProjectTitle;
@property (nonatomic, strong) NSString *ProjectID;

@end
