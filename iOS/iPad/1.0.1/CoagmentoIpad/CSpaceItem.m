//
//  CSpaceItem.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 10/9/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "CSpaceItem.h"

@implementation CSpaceItem
@synthesize csBookmark, csDate, cspaceitem, csThumbnail, csTime, csTitle, csType, csURL, parentParserDelegate;

-(id)getDate{
    return csDate;
}

-(id)getTime{
    return csTime;
}

-(id)getTitle{
    return csTitle;
}

-(id)getURL{
    return csURL;
}

-(id)getBookmark{
    return csBookmark;
}

-(id)getThumbnail{
    return csThumbnail;
}

-(id)getType{
    return csType;
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
        [self setCsTitle:currentString];
    }
    if ([elementName isEqual:@"url"]) {
        currentString = [[NSMutableString alloc] init];
        [self setCsURL:currentString];
    }
    if ([elementName isEqual:@"date"]) {
        currentString = [[NSMutableString alloc] init];
        [self setCsDate:currentString];
    }
    if ([elementName isEqual:@"time"]) {
        currentString = [[NSMutableString alloc] init];
        [self setCsTime:currentString];
    }
    if ([elementName isEqual:@"type"]) {
        currentString = [[NSMutableString alloc] init];
        [self setCsType:currentString];
    }
    if ([elementName isEqual:@"bookmark"]) {
        currentString = [[NSMutableString alloc] init];
        [self setCsBookmark:currentString];
    }
    if ([elementName isEqual:@"thumbnail"]) {
        currentString = [[NSMutableString alloc] init];
        [self setCsThumbnail:currentString];
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
    if ([elementName isEqual:@"item"])
        [parser setDelegate:parentParserDelegate];
    
}


@end
