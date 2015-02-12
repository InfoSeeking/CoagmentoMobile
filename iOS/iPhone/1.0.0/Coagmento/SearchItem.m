//
//  SearchItem.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "SearchItem.h"

@implementation SearchItem
@synthesize parentParserDelegate, searchDate, searchitem, searchQuery, searchSource, searchUrl;


-(id)getQuery{
    return searchQuery;
}
-(id)getURL{
    return searchUrl;
}
-(id)getDate{
    return searchDate;
}
-(id)getSource{
    return searchSource;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"query"]) {
        currentString = [[NSMutableString alloc] init];
        [self setSearchQuery:currentString];
        
    }
    if ([elementName isEqual:@"source"]) {
        currentString = [[NSMutableString alloc] init];
        [self setSearchSource:currentString];
    }
    
    if ([elementName isEqual:@"url"]) {
        currentString = [[NSMutableString alloc] init];
        [self setSearchUrl:currentString];
        
    }
    if ([elementName isEqual:@"date"]) {
        currentString = [[NSMutableString alloc] init];
        [self setSearchDate: currentString];
        
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
    if ([elementName isEqual:@"search"])
        [parser setDelegate:parentParserDelegate];
}




@end
