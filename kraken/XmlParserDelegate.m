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

NSInteger const ParserStateHeader = 0;
NSInteger const ParserStateEntry = 1;

-(id) init{
    self = [super init];
    if(self){
        parserResults = [[NSMutableArray alloc] init];
        state = ParserStateHeader;
    }
    return self;
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(!buffer){
        buffer = [[NSMutableString alloc] initWithString:string];
    }
    else{
        [buffer appendString:string];
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSString* cleanedBuffer = [buffer stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if ([elementName isEqualToString:@"item"]) {
        [parserResults addObject: currentFeedItem];
        return;
    }
    
    SEL elementSelector = NSSelectorFromString(elementName);
    
    if(state == ParserStateHeader){
        if([feedHeader respondsToSelector: elementSelector]){
            [feedHeader setValue:cleanedBuffer forKey:elementName];
        }
    }
    else{
        if([currentFeedItem respondsToSelector:elementSelector]){
            [currentFeedItem setValue:cleanedBuffer forKey:elementName];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"item"]){
        state = ParserStateEntry;
        currentFeedItem = [[FeedItem alloc] init];
    }
}

-(void)parserDidStartDocument:(NSXMLParser *)parser{
    feedHeader = [[FeedHeader alloc] init];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    
}

@end
