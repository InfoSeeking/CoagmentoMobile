//
//  UserViewController.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 9/24/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "UserViewController.h"
#import "UserObject.h"
#import "UserItem.h"

@interface UserViewController ()

@end

@implementation UserViewController
@synthesize UserID, Collaboratorname, Key, Avatarr, Emaill, Namee, Organizationn, Websitee, ProjID, detailItem;

-(void)setDetail:(NSMutableArray *)detail{
    Collaboratorname = [detail objectAtIndex:0];
    UserID = [detail objectAtIndex:1];
}


-(id)copyWithZone:(NSZone *)zone{
    return Key;
}

-(id)getKey{
    return Key;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


-(id)getProjID{
    [self setProjID:[detailItem objectAtIndex:0]];
    return ProjID;
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
    
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element", self, elementName);
    
    
    //IN TABLE VIEW
    if ([elementName isEqual:@"user"]) {
        // When we find an project item, create an instance of projectItem
        user = [[UserObject alloc] init];
        
        // Set up its parent as ourselves so we can regain control of the parser
        [user setParentParserDelegate:self];
        
        // Turn the parser to the RSSItem
        [parser setDelegate:user];
        
        
        
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
    
    UserItem *itemss = [[user userItems] objectAtIndex:0];
    NSString *name = [itemss userName];
    NSString *avatar = [itemss userAvatar];
    NSString *email = [itemss userEmail];
    NSString *organization = [itemss userOrganization];
    NSString *website = [itemss userWebsite];
     
    Namee.text = name;
    Emaill.text = email;
    Organizationn.text = organization;
    Websitee.text = website;
    
    NSURL * imageURL = [NSURL URLWithString:avatar];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];

    [Avatarr setImage:image];
    
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
    
    
    NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/getMembers.php?projID=%@", UserID];
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
