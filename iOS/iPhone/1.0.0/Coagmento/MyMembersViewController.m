//
//  MyMembersViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "MyMembersViewController.h"
#import "MembersItem.h"
#import "MembersObject.h"

@interface MyMembersViewController ()

@end

@implementation MyMembersViewController
@synthesize ProjTitle, ProjID, detailItem, tableView, UserID;


-(id)getProjTitle{
    [self setProjTitle:[detailItem objectAtIndex:1]];
    return ProjTitle;
}

-(id)getProjID{
    [self setProjID:[detailItem objectAtIndex:0]];
    return ProjID;
}

-(id)getUserID{
    [self setUserID:[detailItem objectAtIndex:2]];
    return UserID;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchEntries];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ( [[segue identifier] isEqualToString:@"toMemberInfo"]){
        
        // Assume self.view is the table view
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        if (path == nil) {
            NSLog(@"PATH IS NIL!!!!");
        }
        
        MembersItem *item = [[member membersItems] objectAtIndex:[path row]];
       // CollaboratorItem *item = [[collaborators collabItems] objectAtIndex:[path row]];
        NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:[item memberName], [item memberID], nil];
        
        [segue.destinationViewController setDetail:array];
    }

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
    if ([elementName isEqual:@"memberList"]) {
        // When we find an project item, create an instance of projectItem
        member = [[MembersObject alloc] init];
        
        // Set up its parent as ourselves so we can regain control of the parser
        [member setParentParserDelegate:self];
        
        // Turn the parser to the RSSItem
        [parser setDelegate:member];
        
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
    
    NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/getMembers.php?userID=%@&projID=%@",[self getUserID], [self getProjID]];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [[member membersItems] count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    
    
    MembersItem *item = [[member membersItems] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[item memberName]];
  
    
    
    
    NSLog(@"WRITING MEMBER CELL");
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"toMemberInfo" sender: self];

}

@end
