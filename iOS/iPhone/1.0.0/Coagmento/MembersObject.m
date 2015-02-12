//
//  MembersObject.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "MembersObject.h"
#import "MembersItem.h"

@implementation MembersObject
@synthesize parentParserDelegate, MemberID, MemberName, membersItem, membersItems;


- (id)init
{
    self = [super init];
    
    if (self) {
        // Create the container for the RSSItems this channel has;
        // we'll create the RSSItem class shortly.
        membersItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}



- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t%@ found a %@ element", self, elementName);
    
    //IN OBJECT
    
    // When we find an item, create an instance of Item
    MembersItem *entry = [[MembersItem alloc] init];
    
    
    NSLog(@"MEMBER ENTRY CREATED");
    // Set up its parent as ourselves so we can regain control of the parser
    [entry setParentParserDelegate:self];
    
    // Turn the parser to the RSSItem
    [parser setDelegate:entry];
    [membersItem addObject:entry];
    
    
    
    // Add the item to our array and release our hold on it
    [membersItems addObject:entry];
    
    NSLog(@"Member COUNT %i", [membersItems count]);
}



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str
{
    [currentString appendString:str];
    
}



- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    // If we were in an element that we were collecting the string for,
    // this appropriately releases our hold on it and the permanent ivar keeps
    // ownership of it. If we weren't parsing such an element, currentString
    // is nil already.
    currentString = nil;
    
    // If the element that ended was the channel, give up control to
    // who gave us control in the first place
    if ([elementName isEqual:@"memberList"])
        [parser setDelegate:parentParserDelegate];
    
}





@end
