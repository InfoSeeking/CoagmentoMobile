//
//  MySnippetsViewController.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/15/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnippetObject.h"
#import "SnippetItem.h"
#import "AnnotationObject.h"
#import "AnnotationItem.h"
#import "DetailViewController.h"
#import "AnnotationCollection.h"
#import "SnippetCollection.h"


@interface MySnippetsViewController : UIViewController <NSXMLParserDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    SnippetObject *snippet;
    AnnotationObject *annotation;
    DetailViewController *detail;
    AnnotationCollection *annoationcollection;
    SnippetCollection *snippetcollection;
    NSInteger selectedPhotoIndex;
    
}
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet AnnotationCollection *annotationCollection;
@property (weak, nonatomic) IBOutlet SnippetCollection *snippetCollection;

@property (nonatomic, copy) NSString *ProjID;
@property (nonatomic, copy) NSString *ProjTitle;

-(id)getProjTitle;
-(id)getProjID;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;



//-(void)setDetail:(NSMutableArray *)detail;
- (void)fetchEntries;
@end



