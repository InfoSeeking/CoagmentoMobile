//
//  MySearchesViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "MySearchesViewController.h"
#import "SearchItem.h"
#import "SearchObject.h"
#import "SearchWebViewController.h"
@interface MySearchesViewController ()
@end

@implementation MySearchesViewController
@synthesize ProjTitle, ProjID, tableView, detailItem, SearchCollection;


-(id)getProjTitle{
    [self setProjTitle:[detailItem objectAtIndex:1]];
    return ProjTitle;
}

-(id)getProjID{
    [self setProjID:[detailItem objectAtIndex:0]];
    return ProjID;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchEntries];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Collection View Data Source

-(UICollectionViewCell *)collectionView:(SearchCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SearchesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    SearchItem *item = [[search searItems] objectAtIndex:[indexPath row]];
    
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
    
    
    
    
    
    NSLog(@"WRITING SEARCH CELL");
    
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (ProjID){
        
        return [[search searItems] count];
        
    }
    else{
        return 0;
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedPhotoIndex = [indexPath row];
    [self segue];
    
    
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
    if ([elementName isEqual:@"searchesList"]) {
        // When we find an project item, create an instance of projectItem
        search = [[SearchObject alloc] init];
        
        // Set up its parent as ourselves so we can regain control of the parser
        [search setParentParserDelegate:self];
        
        // Turn the parser to the RSSItem
        [parser setDelegate:search];
        
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
    
    if (ProjID){
        [self.SearchCollection reloadData];
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
    
    NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/getSearches.php?projID=%@",[self getProjID]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"Fetch Data");
    
    // Put that URL into an NSURLRequest
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Create a connection that will exchange this request for data from the URL
    connection = [[NSURLConnection alloc] initWithRequest:req
                                                 delegate:self
                                         startImmediately:YES];
    
    
}





-(void)segue{
    
    [self performSegueWithIdentifier:@"toSearchWebView" sender:self];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toSearchWebView"]) {
        
        SearchItem *item = [[SearchItem alloc]init];
        
      
        item = [[search searItems] objectAtIndex:selectedPhotoIndex];
        
        
        NSString *url = [item getURL];
        
        [segue.destinationViewController setDetailItem:url];
    }
}


@end
