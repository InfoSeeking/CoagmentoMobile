//
//  MyCSpaceViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.


#import "MyCSpaceViewController.h"
#import "CSpaceObject.h"
#import "CSpaceItem.h"
#import "CSpaceCollectionCell.h"
#import "CSpaceCollection.h"


@interface MyCSpaceViewController ()


@end

@implementation MyCSpaceViewController

@synthesize ProjTitle, ProjID, UserID, CSpaceCollection, CSpaceCache, CSpaceCacheImages , loggedIn;


- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
    }
}


-(id)getProjTitle{
    [self setProjTitle:[_detailItem objectAtIndex:1]];
    return ProjTitle;
}

-(id)getProjID{
    [self setProjID:[_detailItem objectAtIndex:0]];
    return ProjID;
}

-(id)getUserID{
    [self setUserID:[_detailItem objectAtIndex:2]];
    return UserID;
}

//-(void)makeBlank{
//    loggedIn = NO;
//
//    //SHOW AND HIDE COLLECTION HEREE
//}

-(void)beginLoadIndicator{
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)]; // I do this because I'm in landscape mode
    [self.view addSubview:spinner];
    [spinner startAnimating];



}

-(void)endLoadIndicator{
    
    //[progress stopAnimating];
    [spinner stopAnimating];
   // [alert dismissWithClickedButtonIndex:0 animated:NO];
    //[alert removeFromSuperview];
    //alert = nil;
   

}

-(void)viewWillAppear:(BOOL)animated{
    [self getProjID];
    //[super viewDidLoad];
   // [self fetchEntries];
  //  [blankView setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
      NSLog(@"CSPACE DISAPPEARING");

    
}

- (void)viewDidLoad
{
        [super viewDidLoad];
  
        [self getProjID];
    if (ProjID!= nil) {
        
        [self getProjTitle];
        [self getUserID];
        [self fetchEntries];
    }
 
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parser

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element", self, elementName);
    
    //IN TABLE VIEW
    if ([elementName isEqual:@"cspaceList"]) {
        // When we find an project item, create an instance of projectItem
        cspace = [[CSpaceObject alloc] init];
        
        // Set up its parent as ourselves so we can regain control of the parser
        [cspace setParentParserDelegate:self];
        
        // Turn the parser to the RSSItem
        [parser setDelegate:cspace];
        
    }
    
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}

#pragma mark Connection

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    // Add the incoming chunk of data to the container we are keeping
    // The data always comes in the correct order
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    // Create the parser object with the data received from the web service
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    
    // Give it a delegate
    [parser setDelegate:self];
    
    // Tell it to start parsing - the document will be parsed and
    // the delegate of NSXMLParser will get all of its delegate messages
    // sent to it before this line finishes execution - it is blocking
    [parser parse];
    
    // Get rid of the XML data as we no longer need it
    xmlData = nil;
    
    // Get rid of the connection, no longer need it
    connection = nil;
  
    // Reload the table.. for now, the table will be empty. MUST LOAD TABLE!!
   
  //   [self loadImages];
 
    
    if (UserID){
    [self.CSpaceCollection reloadData];
    }
    
}

- (void)connection:(NSURLConnection *)conn
  didFailWithError:(NSError *)error
{
    // Release the connection object, we're done with it
    connection = nil;

    // Release the xmlData object, we're done with it
    xmlData = nil;
    
    // Grab the description of the error object passed to us
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@",
                             [error localizedDescription]];
    
    // Create and show an alert view with this error displayed
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                 message:errorString
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [av show];
}

- (void)fetchEntries
{
    
    // Create a new data container for the stuff that comes back from the service
    xmlData = [[NSMutableData alloc] init];
    
    // Construct a URL that will ask the service for what you want -
    // note we can concatenate literal strings together on multiple
    // lines in this way - this results in a single NSString instance
    
    NSString *urlString =[[NSString alloc] initWithFormat:@"http://www.coagmento.org/mobile/getCSpace.php?userID=%@&projID=%@",[self getUserID],[self getProjID]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"CSPACE Fetch Data");
    
    // Put that URL into an NSURLRequest
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Create a connection that will exchange this request for data from the URL
    connection = [[NSURLConnection alloc] initWithRequest:req
                                                 delegate:self
                                         startImmediately:YES];
    
}

- (void)unloadCollection{
    //this array throws in an invalid url and then reloads the table causing it to refresh as an empty collection
    NSMutableArray *zeroArray = [[NSMutableArray alloc]initWithObjects:@"", @"", @"1", nil];
    _detailItem = zeroArray;
}

-(void)loadImages{
    

    
    CSpaceCache = [[NSArray alloc]init];
    CSpaceCache = [cspace cspaceItems];
    CSpaceCacheImages = [[NSMutableArray alloc]init];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        for (int i = 0; i < [CSpaceCache count]; i++) {
            
            NSURL *url = [NSURL URLWithString:[[CSpaceCache objectAtIndex:i] csThumbnail]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [[UIImage alloc] initWithData:data];
            
            [CSpaceCacheImages addObject:img];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            [activityIndicator stopAnimating];
        });
    });
    
    

}




#pragma mark - Collection View Data Source

-(UICollectionViewCell *)collectionView:(CSpaceCollection *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (UserID){
    
        CSpaceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
     CSpaceItem *item = [[cspace cspaceItems] objectAtIndex:[indexPath row]];
    //    CSpaceItem *item = [CSpaceCache objectAtIndex:[indexPath row]];
        
    //IMAGE FOR TABLE CELL INSTANTIATED HERE
    NSURL *url = [NSURL URLWithString:[item csThumbnail]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
        
   // UIImage *img = [CSpaceCacheImages objectAtIndex:[indexPath row]];
    CGRect rect = CGRectMake(0, 0, 328, 362);
  UIGraphicsEndImageContext();

    
    // Create bitmap image from original image data,
    // using rectangle to specify desired crop area
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], rect);
    
   // UIImage *imgg = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
  
    // Create and show the new image from bitmap data
    
    [[cell CollectionCellImage] setFrame:rect];
    [[cell CollectionCellImage] setImage:img];
    [[cell LabelTitle] setText:[item csTitle]];
    [[cell Detail] setText:[item csURL]];
    NSLog(@"WRITING CSPACE CELL");
    
    
    return cell;
    }
    else{
        return nil;
        
    }
    
  
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (UserID){

    return [[cspace cspaceItems] count];

    }
    else{
        return 0;
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedPhotoIndex = [indexPath row];
    [self segue];
    
    
}



- (void) removeNaughtyLingeringCells {
/*
    // 1. Find the visible cells
    NSArray *visibleCells = self.CSpaceCollection.visibleCells;
    NSLog(@"We have %i visible cells", visibleCells.count);
    
    
    // 2. Find the visible rect of the collection view on screen now
    CGRect visibleRect;
    visibleRect.origin = self.CSpaceCollection.contentOffset;
    visibleRect.size = self.CSpaceCollection.bounds.size;
    NSLog(@"Rect %@", NSStringFromCGRect(visibleRect));
    
    
    // 3. Find the subviews that shouldn't be there and remove them
    NSLog(@"We have %i subviews", self.CSpaceCollection.subviews.count);
    for (UIView *aView in [self.CSpaceCollection subviews]) {
        if ([aView isKindOfClass:CSpaceCollectionCell.class]) {
            CGPoint origin = aView.frame.origin;
            if(CGRectContainsPoint(visibleRect, origin)) {
                if ([visibleCells containsObject:aView]) {
                    [aView removeFromSuperview];
                
                }
            }
        }
    }
    //NSLog(@"%i views shouldn't be there", viewsShouldntBeThere.count);
    
    // 4. Refresh the collection view display
    [self.CSpaceCollection setNeedsDisplay];
    
    */
    [self unloadCollection];
    
    
}



#pragma mark - Table view delegate



-(void)segue{
    
    [self performSegueWithIdentifier:@"toPopup" sender:self];
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toPopup"]) {
     
      //  CSpaceItem *item = [[cspace cspaceItems] objectAtIndex:selectedPhotoIndex];
    //    NSString *url = [item getURL];
        
     //   NSMutableArray *detail = [[NSMutableArray alloc]init];
     //   CSpaceItem *detail = [[CSpaceItem alloc]init];
        CSpaceItem *detail = [[cspace cspaceItems] objectAtIndex:selectedPhotoIndex];
        
       // detail = [CSpaceCache objectAtIndex:selectedPhotoIndex];
                NSString *title = [detail csTitle];
        NSString *date = [detail csDate];
        NSString *url = [detail csURL];
        NSString *type = [detail csType];
        NSString *time = [detail csTime];
        NSMutableArray *detailitem = [[NSMutableArray alloc]initWithObjects:title, date, time, type, url, nil];

        [segue.destinationViewController setDetailItem:detailitem];
    }
}

@end
