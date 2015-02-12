//
//  AnnotationItem.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "AnnotationItem.h"

@implementation AnnotationItem
@synthesize parentParserDelegate, annotationDate, annotationitem, annotationTime, annotationTitle, annotationUrl;

-(id)getDate{
    return annotationDate;
}

-(id)getTime{
    return annotationTime;
}

-(id)getTitle{
    return annotationTitle;
}

-(id)getURL{
    return annotationUrl;
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
        [self setAnnotationTitle:currentString];
    }
    if ([elementName isEqual:@"url"]) {
        currentString = [[NSMutableString alloc] init];
        [self setAnnotationUrl:currentString];
    }
    if ([elementName isEqual:@"date"]) {
        currentString = [[NSMutableString alloc] init];
        [self setAnnotationDate:currentString];
    }
    if ([elementName isEqual:@"time"]) {
        currentString = [[NSMutableString alloc] init];
        [self setAnnotationTime:currentString];
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
