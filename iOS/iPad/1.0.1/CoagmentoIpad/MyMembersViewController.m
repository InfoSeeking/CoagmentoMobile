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

#import "UserObject.h"
#import "UserItem.h"

@interface MyMembersViewController ()

@end

@implementation MyMembersViewController
@synthesize ProjTitle, ProjID, detailItem, MemberCollection;
@dynamic UserID, Avatarr, Emaill, Namee, Websitee, Organizationn;


-(id)getProjTitle{
    [self setProjTitle:[detailItem objectAtIndex:1]];
    return ProjTitle;
}

-(id)getProjID{
    [self setProjID:[detailItem objectAtIndex:0]];
    return ProjID;
}

-(id)getUserID{
    return [detailItem objectAtIndex:2];
}


- (void)viewWillAppear:(BOOL)animated{
    [self getProjID];
    [super viewDidLoad];
    [self fetchEntries];
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
        user = [[UserObject alloc] init];
        
        // Set up its parent as ourselves so we can regain control of the parser
        [user setParentParserDelegate:self];
        
        // Turn the parser to the RSSItem
        [parser setDelegate:user];
        
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
    
    [self.MemberCollection reloadData];
    
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



/*

-(void)fetchUserDetails:(NSString *)memberID
{
    
    // Create a new data container for the stuff that comes back from the service
    xmlData = [[NSMutableData alloc] init];
    
   
    
    NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/getUser.php?userID=%@", memberID];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"Fetch Data");
    
    // Put that URL into an NSURLRequest
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Create a connection that will exchange this request for data from the URL
    connection2 = [[NSURLConnection alloc] initWithRequest:req
                                                 delegate:self
                                         startImmediately:YES];
    
}


- (void)parser2:(NSXMLParser *)parser2
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
        [parser2 setDelegate:user];
        
        
        
    }
    
    
}

- (void)connection2:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    // Add the incoming chunk of data to the container we are keeping
    // The data always comes in the correct order
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading2:(NSURLConnection *)conn
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


- (void)connection2:(NSURLConnection *)conn
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

 
 */


- (void)fetchEntries
{
    // Create a new data container for the stuff that comes back from the service
    xmlData = [[NSMutableData alloc] init];
    
    // Construct a URL that will ask the service for what you want -
    // note we can concatenate literal strings together on multiple
    // lines in this way - this results in a single NSString instance
    
    
    NSString *urlString =[[NSString alloc] initWithFormat:@"http://coagmento.org/mobile/getMembers.php?&projID=%@", [self getProjID]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"Fetch Data");
    
    // Put that URL into an NSURLRequest
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Create a connection that will exchange this request for data from the URL
    connection = [[NSURLConnection alloc] initWithRequest:req
                                                 delegate:self
                                         startImmediately:YES];
    
    
}



#pragma mark - Collection View Data Source

-(UICollectionViewCell *)collectionView:(MembersCollection *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MembersCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    UserItem *item = [[user userItems] objectAtIndex:[indexPath row]];
    

    
    [[cell memberEmail] setText:[item userEmail]];
    [[cell memberName] setText:[item userName]];
    [[cell memberOrg] setText:[item userOrganization]];
    
    NSString *avatar = [item userAvatar];
    
    NSURL * imageURL = [NSURL URLWithString:avatar];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    [[cell MemberImage] setImage:image];


    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (ProjID){
        
        return [[user userItems] count];
        
    }
    else{
        return 0;
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   // selectedPhotoIndex = [indexPath row];
  
    
    
}





@end
