//
//  UserItem.m
//  CoagmentoIOS
//
//  Created by Josue Reyes on 9/23/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import "UserItem.h"

@implementation UserItem
@synthesize parentParserDelegate, userAvatar, userEmail, userID, useritem, userName, userOrganization, userWebsite;

-(id)getID{
    return userID;
}

-(id)getAvatar{
    return userAvatar;
}

-(id)getEmail{
    return userEmail;
}

-(id)getName{
    return userName;
}

-(id)getOrganization{
    return userOrganization;
}

-(id)getWebsite{
    return userWebsite;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element in ITEM", self, elementName);
    
    if ([elementName isEqual:@"avatar"]) {
        currentString = [[NSMutableString alloc] init];
        [self setUserAvatar:currentString];
    }
    if ([elementName isEqual:@"email"]) {
        currentString = [[NSMutableString alloc] init];
        [self setUserEmail:currentString];
    }
    if ([elementName isEqual:@"organization"]) {
        currentString = [[NSMutableString alloc] init];
        [self setUserOrganization:currentString];
    }
    if ([elementName isEqual:@"website"]) {
        currentString = [[NSMutableString alloc] init];
        [self setUserWebsite:currentString];
    }
    if ([elementName isEqual:@"userName"]) {
        currentString = [[NSMutableString alloc] init];
        [self setUserName:currentString];
    }
    if ([elementName isEqual:@"userID"]) {
        currentString = [[NSMutableString alloc] init];
        [self setUserID:currentString];
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
    if ([elementName isEqual:@"user"])
        [parser setDelegate:parentParserDelegate];
    
}




@end
