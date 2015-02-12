//
//  CollaboratorItem.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/14/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "CollaboratorItem.h"
#import "ID.h"

@implementation CollaboratorItem
@synthesize parentParserDelegate, collaboratorItemId, collaboratorItemName;


-(id)getID{
    return collaboratorItemId;
}

-(id)getTitle{
    return collaboratorItemName;
}



- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"collabName"]) {
        currentString = [[NSMutableString alloc] init];
        [self setCollaboratorItemName:currentString];
    }
    else if ([elementName isEqual:@"collabID"]) {
        currentString = [[NSMutableString alloc] init];
        [self setCollaboratorItemId:currentString];
    }
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
    currentString = nil;
    
    
    //IN ITEM
    if ([elementName isEqual:@"collaborator"])
        [parser setDelegate:parentParserDelegate];
}



@end
