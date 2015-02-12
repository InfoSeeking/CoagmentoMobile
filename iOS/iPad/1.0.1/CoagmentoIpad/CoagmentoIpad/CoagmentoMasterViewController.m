//
//  CoagmentoMasterViewController.m
//  CoagmentoIpad
//  Created by Josue Reyes on 10/8/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.


#import "CoagmentoMasterViewController.h"
#import "CoagmentoViewController.h"
#import "SignIn.h"
#import "IDsingleton.h"
#import "CollaboratorItem.h"
#import "CollaboratorName.h"
#import "projectItem.h"
#import "ProjectObject.h"
#import "SignIn.h"


@interface CoagmentoMasterViewController  () {
    NSMutableArray *_objects;
}
@end

@implementation CoagmentoMasterViewController
@synthesize delegate = _delegate;
@synthesize userIDnumero, table, CSpaceCacheImagesArray;

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.detailViewController = (CoagmentoViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.delegate = self.detailViewController;
    IDsingleton * singleton = [[IDsingleton alloc] init];
    self.userIDnumero = [singleton IDstring];
    
}


-(void)setDetail:(NSString *)detail{
   userIDnumero = detail;
   [self fetchEntries];
}


-(void)unloadTableData{
    project = nil;
   [self.table reloadData];
   }

-(void)viewWillAppear:(BOOL)animated{
    
        [self.table reloadData];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ( [[segue identifier] isEqualToString:@"toCSpace"]){
        
        // Assume self.view is the table view
        NSIndexPath *path = [self.table indexPathForSelectedRow];
        
        if (path == nil) {
            NSLog(@"PATH IS NIL!!!!");
        }
        
        
        projectItem *item = [[project projItems] objectAtIndex:[path row]];
        NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:[item getTitle], [item getID], [self userIDnumero], nil];
        
        [segue.destinationViewController setDetail:array];
    }
    

}


-(id)getUserID{
    return userIDnumero;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[project projItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Configure the cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Cell"];
    }
    
    
    
    projectItem *item = [[project projItems] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[item projectItemName]];
    
    
    NSLog(@"WRITING PROJECT CELL");
    
    return cell;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *path = [self.table indexPathForSelectedRow];
    
    if (path == nil) {
        NSLog(@"PATH IS NIL!!!!");
    }
    
    
    projectItem *item = [[project projItems] objectAtIndex:[path row]];
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:[item getTitle], [item getID], [self userIDnumero], nil];
    
    [self.detailViewController setDetail:array];


}

#pragma mark -PassDataDelegate

-(void)passData:(id)sender{
 [self setUserIDnumero:sender];
    
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
        if ([elementName isEqual:@"projectList"]) {
            // When we find an project item, create an instance of projectItem
            project = [[ProjectObject alloc] init];
            
            // Set up its parent as ourselves so we can regain control of the parser
            [project setParentParserDelegate:self];
            
            // Turn the parser to the RSSItem
            [parser setDelegate:project];

        
    }
}



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
    
    
    NSIndexPath *path = [self.table indexPathForSelectedRow];
    
    
    
    if (path == nil) {
        NSLog(@"PATH IS NIL!!!!");
    }
    
    projectItem *item = [[project projItems] objectAtIndex:[path row]];
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:[item getTitle], [item getID], [self userIDnumero], nil];
    [self.detailViewController setDetail:array];

    [self.detailViewController passDataToTabs];
    // Get rid of the XML data as we no longer need it
    xmlData = nil;
    
    // Get rid of the connection, no longer need it
    connection = nil;
    
    // Reload the table.. for now, the table will be empty.

        [table reloadData];
   
    
    //NSLog(@" STATEMENTS %@\n %@\n", [project projectName], [project projectID]);
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}

- (void)connection:(NSURLConnection *)conn
  didFailWithError:(NSError *)error
{
    // Release the connection object, we're done with it
    connection = nil;
    
    // Release the xmlData object, we're done with it
    xmlData = nil;
    
    // Grab the description of the error object passed to us
    NSString *errorString = [NSString stringWithFormat:@"Failed to log in: %@",
                             [error localizedDescription]];
    
    // Create and show an alert view with this error displayed
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                 message:errorString
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [av show];
}

//retrieves stored userID

-(NSString*)retrieveString{
    NSString* recoveredString =
    [[NSUserDefaults
      standardUserDefaults]
     objectForKey:@"String"];
    return recoveredString;
}

-(void)loggingOutRequest{
    
    // Create a new data container for the stuff that comes back from the service
    xmlData = [[NSMutableData alloc] init];
    
    
    NSString *key = [self retrieveString];
    
    
    
    NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/logout.php?userID=%@", key];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"Logging Out");
    
    // Put that URL into an NSURLRequest
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Create a connection that will exchange this request for data from the URL
    connection = [[NSURLConnection alloc] initWithRequest:req
                                                 delegate:self
                                         startImmediately:YES];
    
    //RELEASE USERID AND MAKE IT NOTHING
    
    userIDnumero = 0;
   
}


- (void)fetchEntries
{
    // Create a new data container for the stuff that comes back from the service
    xmlData = [[NSMutableData alloc] init];
    
    
   // NSString *key = [self retrieveString];
    
        NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/projList.php?userID=%@", userIDnumero];
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSLog(@"Fetch Data");
        
        // Put that URL into an NSURLRequest
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        // Create a connection that will exchange this request for data from the URL
        connection = [[NSURLConnection alloc] initWithRequest:req
                                                     delegate:self
                                             startImmediately:YES];
 
    
}


@end
