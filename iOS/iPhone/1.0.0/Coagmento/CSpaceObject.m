//
//  CSpaceObject.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 10/9/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "CSpaceObject.h"
#import "CSpaceItem.h"

@implementation CSpaceObject
@synthesize parentParserDelegate, date, bookmark, cspaceItem, cspaceItems, thumbnail, time, title,type;

- (id)init
{
    self = [super init];
    
    if (self) {
        // Create the container for the RSSItems this channel has;
        // we'll create the RSSItem class shortly.
        cspaceItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t%@ found a %@ element in OBJECT", self, elementName);
    
    //IN OBJECT
    
    // When we find an item, create an instance of Item
    CSpaceItem *entry = [[CSpaceItem alloc] init];
    
    
    NSLog(@"CSPACE ENTRY CREATED");
    // Set up its parent as ourselves so we can regain control of the parser
    [entry setParentParserDelegate:self];
    
    // Turn the parser to the RSSItem
    [parser setDelegate:entry];
    [cspaceItem addObject:entry];
    
    
    
    // Add the item to our array and release our hold on it
    [cspaceItems addObject:entry];
    
    NSLog(@"CSPACE COUNT %i", [cspaceItems count]);
    
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str
{
    [currentString appendString:str];
    
}


-(void)parser:(NSXMLParser *)parser
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
    if ([elementName isEqual:@"item"])
        [parser setDelegate:parentParserDelegate];
    
}


@end
