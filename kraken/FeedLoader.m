//
//  FeedLoader.m
//  kraken
//
//  Created by Jan Schulte on 01/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import "FeedLoader.h"
#import "XmlParserDelegate.h"

@implementation FeedLoader

-(NSArray *) loadFeeds:(NSArray *)urls{
    
    NSString *firstUrl = [urls objectAtIndex:0];
    
    XmlParserDelegate *delegate = [[XmlParserDelegate alloc] init];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL: [NSURL URLWithString: firstUrl]];
    
    [parser setDelegate:delegate];
    
    BOOL parsedSuccessfully = [parser parse];
    
    NSLog(@"parsed successfully: %hhd", parsedSuccessfully);
    
    return [delegate parserResults];
}

@end
