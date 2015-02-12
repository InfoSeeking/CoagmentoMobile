//
//  VistedItem.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 9/13/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "VistedItem.h"

@implementation VistedItem
@synthesize visDate, visteditem, visTime, visTitle, visURL, parentParserDelegate;

-(id)getDate{
    return visDate;
}

-(id)getTime{
    return visTime;
}

-(id)getTitle{
    return visTitle;
}

-(id)getURL{
    return visURL;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element in ITEM", self, elementName);
    
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setVisTitle:currentString];
    }
    if ([elementName isEqual:@"url"]) {
        currentString = [[NSMutableString alloc] init];
        [self setVisURL:currentString];
    }
    if ([elementName isEqual:@"date"]) {
        currentString = [[NSMutableString alloc] init];
        [self setVisDate:currentString];
    }
    if ([elementName isEqual:@"time"]) {
        currentString = [[NSMutableString alloc] init];
        [self setVisTime:currentString];
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
    if ([elementName isEqual:@"webpage"])
        [parser setDelegate:parentParserDelegate];
    
}



@end
