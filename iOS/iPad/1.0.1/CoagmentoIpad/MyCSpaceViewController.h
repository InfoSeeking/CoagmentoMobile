//
//  MyCSpaceViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSpaceItem.h"
#import "CSpaceObject.h"
#import "CSpaceCollection.h"

@interface MyCSpaceViewController : UIViewController  <NSXMLParserDelegate,UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    CSpaceObject *cspace;
    NSInteger selectedPhotoIndex;
    UIActivityIndicatorView *progress;
    UIActivityIndicatorView *spinner;
    UIAlertView *alert;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
    
}

@property (strong, nonatomic) id detailItem;
@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;
@property (nonatomic, copy) NSString *UserID;
@property (nonatomic, copy) NSArray *CSpaceCache;
@property (nonatomic, copy) NSMutableArray *CSpaceCacheImages;
@property (nonatomic) Boolean * loggedIn;


@property (weak, nonatomic) IBOutlet CSpaceCollection *CSpaceCollection;



-(id)getProjTitle;
-(id)getProjID;
-(id)getUserID;
-(void)removeNaughtyLingeringCells;

//-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;
@end
