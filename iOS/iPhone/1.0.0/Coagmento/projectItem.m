//
//  projectItem.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 7/17/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "projectItem.h"
#import "ID.h"

@implementation projectItem
@synthesize projectItemId, projectItemName, projectitem, parentParserDelegate;


-(id)getID{
    return projectItemId;
}

-(id)getTitle{
    return projectItemName;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"projID"]) {
        currentString = [[NSMutableString alloc] init];
        [self setProjectItemId:currentString];
        
    }
    if ([elementName isEqual:@"projName"]) {
        currentString = [[NSMutableString alloc] init];
        [self setProjectItemName:currentString];
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
    if ([elementName isEqual:@"project"])
        [parser setDelegate:parentParserDelegate];
}


@end


