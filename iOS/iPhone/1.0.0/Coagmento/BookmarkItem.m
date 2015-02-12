//
//  BookmarkItem.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/15/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "BookmarkItem.h"

@implementation BookmarkItem
@synthesize parentParserDelegate, bmDate, bmTime, bmTitle, bmURL, bookmarkitem;

-(id)getDate{
    return bmDate;
}

-(id)getTime{
    return bmTime;
}

-(id)getTitle{
    return bmTitle;
}

-(id)getURL{
    return bmURL;
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
        [self setBmTitle:currentString];
    }
    if ([elementName isEqual:@"url"]) {
        currentString = [[NSMutableString alloc] init];
        [self setBmURL:currentString];
    }
    if ([elementName isEqual:@"date"]) {
        currentString = [[NSMutableString alloc] init];
        [self setBmDate:currentString];
    }
    if ([elementName isEqual:@"time"]) {
        currentString = [[NSMutableString alloc] init];
        [self setBmTime:currentString];
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
    if ([elementName isEqual:@"bookmark"])
        [parser setDelegate:parentParserDelegate];
    
}


@end
