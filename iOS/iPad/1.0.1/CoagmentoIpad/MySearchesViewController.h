//
//  MySearchesViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchItem.h"
#import "SearchObject.h"
#import "SearchCollectionView.h"

@interface MySearchesViewController : UIViewController  <NSXMLParserDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    SearchObject *search;
    NSInteger selectedPhotoIndex;
    
}
@property (strong, nonatomic) id detailItem;

@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;

@property (weak, nonatomic) IBOutlet SearchCollectionView *SearchCollection;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(id)getProjTitle;
-(id)getProjID;


//-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;


@end
