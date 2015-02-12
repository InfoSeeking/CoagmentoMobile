//
//  MySnippetsViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/15/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "MySnippetsViewController.h"
#import "SnippetItem.h"
#import "SnippetObject.h"
#import "DetailViewController.h"
#import "AnnotationItem.h"
#import "AnnotationObject.h"
#import "tabBarItem.h"

@interface MySnippetsViewController ()

@end

@implementation MySnippetsViewController
@synthesize ProjTitle, ProjID, tableView, detailItem, tableView2, segment;


-(id)getProjTitle{
   [self setProjTitle:[detailItem objectAtIndex:1]];
    return ProjTitle;
}

-(id)getProjID{
    [self setProjID:[detailItem objectAtIndex:0]];
    return ProjID;
}


- (IBAction)segmentChange {

    
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchEntries];
//     [UIViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"selected.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"unselect.png"]];
    
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
    if ([elementName isEqual:@"snippetsList"]) {
        // When we find an project item, create an instance of projectItem
        snippet = [[SnippetObject alloc] init];
        
        // Set up its parent as ourselves so we can regain control of the parser
        [snippet setParentParserDelegate:self];
        
        // Turn the parser to the RSSItem
        [parser setDelegate:snippet];
        
    }
}
    
    if(segment.selectedSegmentIndex==1){
        if ([elementName isEqual:@"annotationsList"]) {
            // When we find an project item, create an instance of projectItem
            annotation = [[AnnotationObject alloc] init];
            
            // Set up its parent as ourselves so we can regain control of the parser
            [annotation setParentParserDelegate:self];
            
            // Turn the parser to the RSSItem
            [parser setDelegate:annotation];
            
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
    
    NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/getSnippets.php?projID=%@",[self getProjID]];
    NSString *urlStringg =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/getAnnotations.php?projID=%@", [self getProjID]];
    
    if(segment.selectedSegmentIndex==0){
        NSURL *url = [NSURL URLWithString:urlString];
        
        
        NSLog(@"Fetch Data");
        
        // Put that URL into an NSURLRequest
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        // Create a connection that will exchange this request for data from the URL
        connection = [[NSURLConnection alloc] initWithRequest:req
                                                     delegate:self
                                             startImmediately:YES];
    }
    
    
    
    if(segment.selectedSegmentIndex==1){
        NSURL *url = [NSURL URLWithString:urlStringg];
        
        
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
    return [[snippet snipItems] count];
    }
    
    if(segment.selectedSegmentIndex==1)
    {
    return [[annotation annotationItems] count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    if(segment.selectedSegmentIndex==0)
    {

    
    SnippetItem *item = [[snippet snipItems] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[item snipTitle]];
    [[cell detailTextLabel] setText:[item snipNote]];
    
    NSLog(@"WRITING SNIPPET CELL");
   
        return  cell;
    }
    
    
    if(segment.selectedSegmentIndex==1)
    {
        AnnotationItem *item = [[annotation annotationItems] objectAtIndex:[indexPath row]];
        
        
        [[cell textLabel] setText:[item annotationTitle]];
        [[cell detailTextLabel] setText:[item annotationDate]];
        
        NSLog(@"WRITING ANNOTATION CELL");
        
        
        return cell;

    }
    
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(segment.selectedSegmentIndex==0)
    {
        [self performSegueWithIdentifier:@"showDetail" sender:self];
        
    }
    
    if(segment.selectedSegmentIndex==1)
    {
        [self performSegueWithIdentifier:@"showWeb" sender:self];
        
    }

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"] && segment.selectedSegmentIndex == 0) {

        
        
        
        // Assume self.view is the table view
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        SnippetItem *item = [[snippet snipItems] objectAtIndex:[path row]];
        NSMutableArray *string = [[NSMutableArray alloc]initWithObjects:[item getTitle], [item getContent], [item getURL], [item getNote], [item getDate], nil];
        
               
        [segue.destinationViewController setDetailItem:string];
    }
    
     
   if ([[segue identifier] isEqualToString:@"showWeb"] && segment.selectedSegmentIndex == 1) {
    
       
       NSIndexPath *path = [[self tableView2] indexPathForSelectedRow];
       AnnotationItem *item = [[annotation annotationItems] objectAtIndex:[path row]];
       NSString *url = [item getURL];
       
       [segue.destinationViewController setDetailItem:url];
    
    }

    
}


@end
