//
//  ProjectsTVC.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/16/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "ProjectsTVC.h"
#import "ProjectObject.h"
#import "projectItem.h"
#import "ID.h"
#import "CollabProjItem.h"
#import "CollabProjObject.h"


@interface ProjectsTVC ()

@end

@implementation ProjectsTVC
@synthesize Collaboratorname, CollaboratorID, ProjID, Key;

-(void)setDetail:(NSMutableArray *)detail{
     Collaboratorname = [detail objectAtIndex:0];
     CollaboratorID = [detail objectAtIndex:1];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
      //  [self fetchEntries];
        [self setKey:Key];
    }
    
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    return Key;
}

-(id)getKey{
    return Key;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    //initData
}


- (void)viewDidLoad
{
   //[super viewDidLoad];
    NSString *title = @"Info";
    NSMutableString *titlee = [[NSMutableString alloc] initWithString:title];
   //   [titlee appendString:Collaboratorname];
    
    self.navigationItem.title = titlee;
    //DID WE PASS IN THE PROJECT OBJECT FROM HOME?
    NSLog(@"COLLABORATOR NAME: %@",Collaboratorname);
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       return [[project collabprojItems] count];
  
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
          [[segue identifier] isEqualToString:@"toTabBar2"];
        
        
        
        // Assume self.view is the table view
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    
    
        projectItem *item = [[project collabprojItems] objectAtIndex:[path row]];
        NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:[item getTitle], [item getID], nil];
        
        
        [segue.destinationViewController setDetail:array];
    

}

-(void)segue{
    
    [self performSegueWithIdentifier:@"toTabBar2" sender:self];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                      reuseIdentifier:@"Cell"];
//    }
//    
//    projectItem *item = [[project collabprojItems] objectAtIndex:[indexPath row]];
// 
//    [[cell textLabel] setText:[item projectItemName]];
//
// 
//    
//    NSLog(@"WRITING CELL");
//    
//    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSLog(@"INSIDE: PROJECTSTVC-tableView-didSelectRow..");
    
    [self segue];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element", self, elementName);
   
   
    //IN TABLE VIEW
    if ([elementName isEqual:@"projList"]) {
        // When we find an project item, create an instance of projectItem
        project = [[CollabProjObject alloc] init];
        
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
    
    // Get rid of the XML data as we no longer need it
    xmlData = nil;
    
    // Get rid of the connection, no longer need it
    connection = nil;
    
    // Reload the table.. for now, the table will be empty.
    [[self tableView] reloadData];
    
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


- (void)fetchEntries
{
    // Create a new data container for the stuff that comes back from the service
    xmlData = [[NSMutableData alloc] init];
    
    // Construct a URL that will ask the service for what you want -
    // note we can concatenate literal strings together on multiple
    // lines in this way - this results in a single NSString instance
    
//    TabNavViewControl *Nav = [[TabNavViewControl alloc]init];
   // ID keyPathsForValuesAffectingValueForKey:key;
    NSString *key = [self retrieveString];
       NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/collabInfo.php?userID=%@&collabID=%@", key, CollaboratorID];
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








