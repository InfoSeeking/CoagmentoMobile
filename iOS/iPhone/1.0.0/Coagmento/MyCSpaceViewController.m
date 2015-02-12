//
//  MyCSpaceViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "MyCSpaceViewController.h"
#import "CSpaceObject.h"
#import "CSpaceItem.h"
#import "UIImage+Resize.h"

@interface MyCSpaceViewController ()


@end

@implementation MyCSpaceViewController

@synthesize ProjTitle, ProjID, tableView, UserID;


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
    [tableView reloadData];
    
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
    
    NSLog(@"Fetch Data");
    
    // Put that URL into an NSURLRequest
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Create a connection that will exchange this request for data from the URL
    connection = [[NSURLConnection alloc] initWithRequest:req
                                                 delegate:self
                                         startImmediately:YES];
    
}




#pragma mark - Table view data source

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [[cspace cspaceItems] count];
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
 
    
    CSpaceItem *item = [[cspace cspaceItems] objectAtIndex:[indexPath row]];
    
    
    //IMAGE FOR TABLE CELL INSTANTIATED HERE
    NSURL *url = [NSURL URLWithString:[item csThumbnail]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    CGRect rect = CGRectMake(0, 0, 270, 350);
    
    // Create the image from a png file
    
    
    
    // Create bitmap image from original image data,
    // using rectangle to specify desired crop area
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], rect);
    
    UIImage *imgg = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    // Create and show the new image from bitmap data
 
    
    [[cell imageView] setFrame:rect];
    [[cell imageView] setImage:imgg];
    [[cell textLabel] setText:[item csTitle]];
    [[cell detailTextLabel] setText:[item csURL]];
    
    
    NSLog(@"WRITING CSPACE CELL");
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self segue];
    
}


-(void)segue{
    
    [self performSegueWithIdentifier:@"toWeb" sender:self];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toWeb"]) {
        NSIndexPath *path = tableView.indexPathForSelectedRow;
        CSpaceItem *item = [[cspace cspaceItems] objectAtIndex:[path row]];
        NSString *url = [item getURL];
        
        [segue.destinationViewController setDetailItem:url];
    }
}

@end
