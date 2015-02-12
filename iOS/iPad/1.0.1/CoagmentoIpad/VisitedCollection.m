//
//  VisitedCollection.m
//  CoagmentoIpad
//
//  Created by Josue Reyes on 10/31/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "VisitedCollection.h"
#import "VistedObject.h"
#import "VistedItem.h"
#import "VisitedCollectionCell.h"

@implementation VisitedCollection
@synthesize ProjID, ProjTitle, detailItem;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
            }
    return self;
}


-(void)setDetail:(NSMutableArray *)detail{
    ProjID = [detail objectAtIndex:0];
    ProjTitle = [detail objectAtIndex:1];
}


-(id)getProjID{
    //[self setProjID:[detailItem objectAtIndex:0]];
    return ProjID;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element", self, elementName);
    
    //IN TABLE VIEW
    
        if ([elementName isEqual:@"webpageList"]) {
            // When we find an project item, create an instance of projectItem
            visited = [[VistedObject alloc] init];
            
            // Set up its parent as ourselves so we can regain control of the parser
            [visited setParentParserDelegate:self];
            
            // Turn the parser to the RSSItem
            [parser setDelegate:visited];
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
   // NSString *string = [[NSString alloc] initWithData:xmlData encoding: NSUTF8StringEncoding];
    // NSLog(string);
    
    [parser parse];
    
    // Get rid of the XML data as we no longer need it
    xmlData = nil;
    
    // Get rid of the connection, no longer need it
    connection = nil;
    
    // Reload the table.. for now, the table will be empty. MUST LOAD TABLE!!
    
    
    [self reloadData];
   
    
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
    
    
    
    
    NSString *urlStringg =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/getVisited.php?projID=%@", [self getProjID]];
    
    
        NSURL *url = [NSURL URLWithString:urlStringg];
        
        
        NSLog(@"Fetch Data");
        
        // Put that URL into an NSURLRequest
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        // Create a connection that will exchange this request for data from the URL
        connection = [[NSURLConnection alloc] initWithRequest:req
                                                     delegate:self
                                             startImmediately:YES];
    
    
}


#pragma mark - Collection view data source

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    VisitedCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
  //  VistedItem *item = [[visited visitedItems] objectAtIndex:[indexPath row]];
    UIImage* google = [UIImage imageNamed:@"1google.png"];
    [[cell VisitedIcon] setImage:google];
    
    /*
    [[cell Query] setText:[item searchQuery]];
    [[cell Date] setText:[item searchDate]];
    
    UIImage* google = [UIImage imageNamed:@"1google.png"];
    UIImage* bing = [UIImage imageNamed:@"2bing.png"];
    UIImage* wiki = [UIImage imageNamed:@"4wikipedia.png"];
    UIImage* yahoo = [UIImage imageNamed:@"3yahoo.png"];
    
    NSString *googleString = @"google";
    NSString *bingString = @"bing";
    NSString *wikiString = @"wikipedia";
    NSString *yahooString = @"yahoo";
    
     
    
    if ([googleString isEqualToString:[item searchSource]]) {
        [[cell SearchIcon] setImage:google];
    }
    
    if ([bingString isEqualToString:[item searchSource]]) {
        [[cell SearchIcon] setImage:bing];
    }
    
    if ([wikiString isEqualToString:[item searchSource]]) {
        [[cell SearchIcon] setImage:wiki];
    }
    
    if ([yahooString isEqualToString:[item searchSource]]) {
        [[cell SearchIcon] setImage:yahoo];
    }
    
    
    
    */
    
    NSLog(@"WRITING SEARCH CELL");
    
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (ProjID){
        
        return [[visited visitedItems] count];
        
    }
    else{
        return 0;
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
 //   selectedPhotoIndex = [indexPath row];
 //   [self segue];
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
