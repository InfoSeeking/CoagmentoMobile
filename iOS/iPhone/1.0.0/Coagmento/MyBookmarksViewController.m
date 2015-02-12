//
//  MyBookmarksViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/23/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "MyBookmarksViewController.h"
#import "BookmarkItem.h"
#import "BookmarkObject.h"
#import "VistedObject.h"
#import "VistedItem.h"


@interface MyBookmarksViewController ()

@end

@implementation MyBookmarksViewController
@synthesize ProjID, ProjTitle, tableView, detailItem, tableView2, segment;



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

#pragma mark - Parser

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element", self, elementName);
    
    //IN TABLE VIEW
    if(segment.selectedSegmentIndex==0){
        
        if ([elementName isEqual:@"webpageList"]) {
            // When we find an project item, create an instance of projectItem
            visited = [[VistedObject alloc] init];
            
            // Set up its parent as ourselves so we can regain control of the parser
            [visited setParentParserDelegate:self];
            
            // Turn the parser to the RSSItem
            [parser setDelegate:visited];
            
        }
    }
    
    
    
    if(segment.selectedSegmentIndex==1){
  
    if ([elementName isEqual:@"bookmarkList"]) {
        // When we find an project item, create an instance of projectItem
        bookmark = [[BookmarkObject alloc] init];
        
        // Set up its parent as ourselves so we can regain control of the parser
        [bookmark setParentParserDelegate:self];
        
        // Turn the parser to the RSSItem
        [parser setDelegate:bookmark];
        
        }
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
    
     if(segment.selectedSegmentIndex==0){
         [tableView reloadData];
         tableView2.hidden = YES;
         tableView.hidden = NO;

     }
    
    if(segment.selectedSegmentIndex==1){
        [tableView2 reloadData];
        tableView.hidden = YES;
        tableView2.hidden = NO;

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
    
    
    
    NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/getBookmarks.php?projID=%@",[self getProjID]];
    NSString *urlStringg =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/getVisited.php?projID=%@", [self getProjID]];
    
    if(segment.selectedSegmentIndex==0){
        NSURL *url = [NSURL URLWithString:urlStringg];
        
        
        NSLog(@"Fetch Data");
        
        // Put that URL into an NSURLRequest
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        // Create a connection that will exchange this request for data from the URL
        connection = [[NSURLConnection alloc] initWithRequest:req
                                                     delegate:self
                                             startImmediately:YES];
    }

    
    
    if(segment.selectedSegmentIndex==1){
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    NSLog(@"Fetch Data");
    
    // Put that URL into an NSURLRequest
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Create a connection that will exchange this request for data from the URL
    connection = [[NSURLConnection alloc] initWithRequest:req
                                                 delegate:self
                                         startImmediately:YES];
    }
    
    
}




#pragma mark - Table view data source

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    
    if(segment.selectedSegmentIndex==0)
    {
        return [[visited visitedItems] count];
    }
    
    if(segment.selectedSegmentIndex==1)
    {
        return [[bookmark bookmarkItems] count];

    }
    
    return 0;
       
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    if (self.segment.selectedSegmentIndex == 0) {
        NSLog(@"SEGMENT EQUALS 0");
        [self.tableView reloadData];
        
    }
    if (self.segment.selectedSegmentIndex == 1) {
        NSLog(@"SEGEMENT EQUALS 1");
        [self.tableView2 reloadData];
        
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];

    
    if(segment.selectedSegmentIndex==0)
    {
        
        VistedItem *item = [[visited visitedItems] objectAtIndex:[indexPath row]];
        
        
        [[cell textLabel] setText:[item visTitle]];
        [[cell detailTextLabel] setText:[item visDate]];
       
        NSLog(@"WRITING VISITED CELL");
    
        
        return cell;
    }
    
    
    
    
    if(segment.selectedSegmentIndex==1)
    {
    
    BookmarkItem *item = [[bookmark bookmarkItems] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[item bmTitle]];
    [[cell detailTextLabel] setText:[item bmDate]];
    
    
    NSLog(@"WRITING BOOKMARK CELL");
    
    return cell;
        
    }
    
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self segue];
    
}


-(void)segue{
    
    
   // if (self.segment.selectedSegmentIndex == 0) {
  //  [self performSegueWithIdentifier:@"" sender:self];
//    }
    
    
 //   if (self.segment.selectedSegmentIndex == 1) {
    [self performSegueWithIdentifier:@"toBookmarksWebView" sender:self];
 //   }
}

- (IBAction)segmentChanged {
   
    if (self.segment.selectedSegmentIndex == 0) {
        //reload data with PROJECTS
        [self fetchEntries];
        [tableView reloadData];
        tableView2.hidden = YES;
        tableView.hidden = NO;
        
    }
    
    if (self.segment.selectedSegmentIndex == 1){
        //reload data with COLLABORATORS
        [self fetchEntries];
        [tableView2 reloadData];
        tableView.hidden = YES;
        tableView2.hidden = NO;
    }
    
    
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if (segment.selectedSegmentIndex == 0) {
        
        NSIndexPath *path = [[self tableView] indexPathForSelectedRow];
        VistedItem *item = [[visited visitedItems] objectAtIndex:[path row]];
        NSString *url = [item getURL];
        
        [segue.destinationViewController setDetailItem:url];
    }


    if (segment.selectedSegmentIndex == 1) {
        NSIndexPath *path = tableView2.indexPathForSelectedRow;
        BookmarkItem *item = [[bookmark bookmarkItems] objectAtIndex:[path row]];
        NSString *url = [item getURL];
        
        [segue.destinationViewController setDetailItem:url];
    }
    
    
    
    
}





@end