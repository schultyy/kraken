//
//  TimelineViewController.m
//  kraken
//
//  Created by Jan Schulte on 07/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import "TimelineViewController.h"
#include "AppDelegate.h"
#include "FeedLoader.h"

@interface TimelineViewController ()

@end

@implementation TimelineViewController

- (id)init{
    self = [super initWithNibName:@"TimelineView" bundle:nil];
    if (self) {
        // Initialization code here.
        [self setFeedItems: [[NSMutableArray alloc] init]];
        dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"pubDate" ascending:NO];
        AppDelegate *delegate = (AppDelegate*) [[NSApplication sharedApplication] delegate];
        self.managedObjectContext = delegate.managedObjectContext;
    }
    return self;
}

-(void) loadArticles{
    NSArray *feedUrls = [self feeds];
    for(NSInteger i = 0; i < [feedUrls count]; i++){
        NSString* urlStr = [[feedUrls objectAtIndex:i] valueForKey: @"feedUrl"];
        [self processFeed:urlStr];
    }
}

-(void) processFeed: (NSString *) url{
    FeedLoader *loader = [[FeedLoader alloc] init];
    id feedItems = [loader loadFeeds:[NSArray arrayWithObject:url]];
    [[self feedItems] addObjectsFromArray:feedItems];
    
    [[self feedItems] sortUsingDescriptors: @[dateDescriptor]];
    
    [self willChangeValueForKey:@"feedItems"];
    [self didChangeValueForKey:@"feedItems"];
}

-(NSArray *) feeds{
    id fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity: [NSEntityDescription entityForName:@"Feed"
                                         inManagedObjectContext: [self managedObjectContext]]];
    id context = [self managedObjectContext];
    NSError *error = nil;
    return [context executeFetchRequest:fetchRequest error:&error];
}

@end
