//
//  XmlParserDelegate.m
//  kraken
//
//  Created by Jan Schulte on 03/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import "XmlParserDelegate.h"
#import "FeedHeader.h"
#import "FeedItem.h"

@implementation XmlParserDelegate

-(id) init{
    self = [super init];
    if(self){
        parserResults = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSLog(@"Did end element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"Did start element: %@", elementName);
    
}

-(void)parserDidStartDocument:(NSXMLParser *)parser{
    feedHeader = [[FeedHeader alloc] init];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    
}

@end
