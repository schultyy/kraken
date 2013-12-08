//
//  TimelineViewController.h
//  kraken
//
//  Created by Jan Schulte on 07/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FetchController.h"

@interface TimelineViewController : FetchController{
    NSArray *readArticleIds;
}

-(void) markAsRead;

-(void)fav;

@end
