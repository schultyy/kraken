//
//  FeedLoader.h
//  kraken
//
//  Created by Jan Schulte on 01/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedLoader : NSObject

-(NSArray *) loadFeeds: (NSArray *) urls;

@end
