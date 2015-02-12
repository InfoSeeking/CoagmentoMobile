//
//  MembersItem.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 8/21/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "MembersItem.h"

@implementation MembersItem
@synthesize parentParserDelegate, memberID, memberName;

-(id)getMemberName{
    return memberName;
}
-(id)getMemberID{
    return memberID;
}


- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"memberID"]) {
        currentString = [[NSMutableString alloc] init];
        [self setMemberID:currentString];
        
    }
    if ([elementName isEqual:@"memberName"]) {
        currentString = [[NSMutableString alloc] init];
        [self setMemberName:currentString];
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
    if ([elementName isEqual:@"member"])
        [parser setDelegate:parentParserDelegate];
}



@end
