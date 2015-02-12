//
//  CoagmentoViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/16/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "CoagmentoViewController.h"
#import "ID.h"
#import "CollaboratorItem.h"
#import "CollaboratorName.h"
#import "projectItem.h"
#import "ProjectObject.h"
#import "CSpaceViewController.h"
#import "SignInVC.h"



@interface CoagmentoViewController ()

@end

@implementation CoagmentoViewController
@synthesize segment, table, table2, userIDnum, pItem, cItem, Key, arrayProjectsURL, Logout;

-(id)copyWithZone:(NSZone *)zone{
    return Key;
}

-(void)segueLogOut{
    
       // [self performSegueWithIdentifier:@"toSignIn" sender:self];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex ==0){
        [self segueLogOut];
        [self loggingOutRequest];
    }
    
}
- (IBAction)logout:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Logout", nil];
    [actionSheet showInView:self.view];
}

-(id)getKey{
    return Key;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setKey:Key];
    }
    return self;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
     if ( [[segue identifier] isEqualToString:@"toCSpace"]){
         
        // Assume self.view is the table view
        NSIndexPath *path = [self.table indexPathForSelectedRow];
        
        if (path == nil) {
            NSLog(@"PATH IS NIL!!!!");
        }
        
        
          projectItem *item = [[project projItems] objectAtIndex:[path row]];
         NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:[item getTitle], [item getID], [self userIDnum], nil];
        
        [segue.destinationViewController setDetail:array];
    }
    
    
    
    if ( [[segue identifier] isEqualToString:@"toCollabProj"]){
        
        // Assume self.view is the table view
        NSIndexPath *path = [self.table2 indexPathForSelectedRow];
        
        if (path == nil) {
            NSLog(@"PATH IS NIL!!!!");
        }
        
        
        CollaboratorItem *item = [[collaborators collabItems] objectAtIndex:[path row]];
        NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:[item getTitle], [item getID], nil];
        
        [segue.destinationViewController setDetail:array];
    }
    
}






- (void)viewDidLoad
{

   // [self loadData];
    
    [self.navigationItem setHidesBackButton:YES animated:NO];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self fetchEntries];
    NSLog(@"DISAPPEARING AND READING");
   
    
}


- (void)viewWillDisappear:(BOOL)animated
{
   // [self.navigationController setToolbarHidden:NO animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
  //  [self.navigationController setToolbarHidden:YES animated:YES];

    if (self.segment.selectedSegmentIndex == 0) {
          NSLog(@"SEGMENT EQUALS 0");
        [self.table reloadData];

    }
    if (self.segment.selectedSegmentIndex == 1) {
          NSLog(@"SEGEMENT EQUALS 1");
        [self.table2 reloadData];

    }
    
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{ if(segment.selectedSegmentIndex==0)
{
   return [[project projItems] count];
        
}
else
    if (segment.selectedSegmentIndex==1) {
        return[[collaborators collabItems] count];
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    
    
       if(segment.selectedSegmentIndex==0)
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
    if(segment.selectedSegmentIndex==1) {

        
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [table2 dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        //Configure the cell
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"Cell"];
        }
        
        
        CollaboratorItem *item = [[collaborators collabItems] objectAtIndex:[indexPath row]];
        
        [[cell textLabel] setText:[item collaboratorItemName]];
        
        NSLog(@"WRITING COLLAB CELL");
        
        return cell;
    }
    
    
    return nil;
}




-(IBAction) segmentedControlIndexChanged
{
    if (self.segment.selectedSegmentIndex == 0) {
        //reload data with PROJECTS
        [self fetchEntries];
        [table reloadData];
        table2.hidden = YES;
        table.hidden = NO;
        
    }
    
    if (self.segment.selectedSegmentIndex == 1){
        //reload data with COLLABORATORS
        [self fetchEntries];
        [table2 reloadData];
        table.hidden = YES;
        table2.hidden = NO;
    }
    
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.segment.selectedSegmentIndex == 0){
    [self performSegueWithIdentifier: @"toCSpace" sender: self];
    }

    if (self.segment.selectedSegmentIndex == 1) {
        [self performSegueWithIdentifier: @"toCollabProj" sender: self];
    }

    
}





- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element", self, elementName);
    
    
    
    
    if (self.segment.selectedSegmentIndex == 0) {
        
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
    
        if (self.segment.selectedSegmentIndex == 1){
        
        //IN TABLE VIEW
        if ([elementName isEqual:@"collabList"]) {
            // When we find an collaborator object, create an instance of CollaboratorName
            collaborators = [[CollaboratorName alloc] init];
            
            // Set up its parent as ourselves so we can regain control of the parser
            [collaborators setParentParserDelegate:self];
            
            // Turn the parser to the RSSItem
            [parser setDelegate:collaborators];

        }
        
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
    
    // Get rid of the XML data as we no longer need it
    xmlData = nil;
    
    // Get rid of the connection, no longer need it
    connection = nil;
    
    // Reload the table.. for now, the table will be empty.
    if (self.segment.selectedSegmentIndex == 0){
        [table reloadData];
    }
    
    if (self.segment.selectedSegmentIndex == 1){
        [table2 reloadData];
    }
    
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
    
    userIDnum = 0;
    key = 0;
    Key = 0;
    
    
}


- (void)fetchEntries
{
    // Create a new data container for the stuff that comes back from the service
    xmlData = [[NSMutableData alloc] init];
    
   
    NSString *key = [self retrieveString];
    
    if (self.segment.selectedSegmentIndex == 0) {
        NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/projList.php?userID=%@", key];
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSLog(@"Fetch Data");
        
        // Put that URL into an NSURLRequest
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        // Create a connection that will exchange this request for data from the URL
        connection = [[NSURLConnection alloc] initWithRequest:req
                                                     delegate:self
                                             startImmediately:YES];
        
    

        
    }
    
    else if (self.segment.selectedSegmentIndex ==1){
        NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/collabList.php?userID=%@", key];
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












@end
