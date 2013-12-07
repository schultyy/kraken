//
//  FeedItem.h
//  kraken
//
//  Created by Jan Schulte on 03/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedItem : NSObject

@property (retain) NSString *channelTitle;

@property (retain) NSString *title;

@property (retain) NSString *link;

@property (retain) NSString *descriptionText;

@property (retain) NSDate *pubDate;

@property (retain) NSString *guid;

@end
