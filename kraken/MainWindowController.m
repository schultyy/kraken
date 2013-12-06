//
//  MainWindowController.m
//  kraken
//
//  Created by Jan Schulte on 01/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import "MainWindowController.h"
#include "AppDelegate.h"
#include "FeedLoader.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (id)init{
    self = [super initWithWindowNibName:@"MainWindow"];
    if (self) {
        // Initialization code here.
        [self setFeedItems: [[NSMutableArray alloc] init]];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    AppDelegate *delegate = (AppDelegate*) [[NSApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    [self loadArticles];
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
