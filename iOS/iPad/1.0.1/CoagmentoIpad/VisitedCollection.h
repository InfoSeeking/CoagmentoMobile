//
//  VisitedCollection.h
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/31/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VistedObject.h"
@interface VisitedCollection : UICollectionView <NSXMLParserDelegate>
{
    
    NSURLConnection *connection;
    NSMutableData *xmlData;
    VistedObject *visited;
}


@property (strong, nonatomic) id detailItem;
@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;


//-(id)getProjTitle;
-(id)getProjID;


-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;


@end
