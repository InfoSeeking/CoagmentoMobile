//
//  SnippetItem.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/15/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "SnippetItem.h"

@implementation SnippetItem
@synthesize parentParserDelegate, snipContent, snipDate, snippetitem, snipTitle, snipUrl, snipNote;


-(id)getTitle{
    return snipTitle;
}

-(id)getContent{
    return snipContent;
}

-(id)getDate{
    return snipDate;
}

-(id)getURL{
    return snipUrl;
}

-(id)getNote{
    return snipNote;
}


- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setSnipTitle:currentString];
        
    }
    if ([elementName isEqual:@"url"]) {
        currentString = [[NSMutableString alloc] init];
        [self setSnipUrl:currentString];
    }
   
    if ([elementName isEqual:@"content"]) {
        currentString = [[NSMutableString alloc] init];
        [self setSnipContent:currentString];
        
    }
    if ([elementName isEqual:@"date"]) {
        currentString = [[NSMutableString alloc] init];
        [self setSnipDate: currentString];
        
    }
    if ([elementName isEqual:@"note"]) {
        currentString = [[NSMutableString alloc] init];
        [self setSnipNote: currentString];
        
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
    if ([elementName isEqual:@"snippet"])
        [parser setDelegate:parentParserDelegate];
}





@end
