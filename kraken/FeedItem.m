//
//  FeedItem.m
//  kraken
//
//  Created by Jan Schulte on 03/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import "FeedItem.h"

@implementation FeedItem

-(NSString *) teaser{
    if([[self descriptionText] length] < 100){
        return [self descriptionText];
    }
    NSString *teaser = [[self descriptionText] substringWithRange: NSMakeRange(0, 100)];
    return [teaser stringByAppendingString:@"..."];
}

@end
