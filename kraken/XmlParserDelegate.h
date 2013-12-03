//
//  XmlParserDelegate.h
//  kraken
//
//  Created by Jan Schulte on 03/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"
#import "FeedHeader.h"

@interface XmlParserDelegate : NSObject<NSXMLParserDelegate>{
    NSMutableArray  *parserResults;
    FeedItem        *currentFeedItem;
    FeedHeader      *feedHeader;
}

@end
