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
#include "FeedItem.h"
#include "Underscore.h"

@interface TimelineViewController ()

@end

@implementation TimelineViewController

- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void) buildContextMenu{
    [super buildContextMenu];
    [[self contextMenu] insertItemWithTitle:@"Mark as read" action:@selector(markAsRead) keyEquivalent:@"" atIndex:1];
    [[self contextMenu] insertItemWithTitle:@"Fav" action:@selector(fav) keyEquivalent:@"" atIndex:2];
}

-(BOOL) canAddArticle:(FeedItem *)obj{
    return ![readArticleIds containsObject:[obj valueForKey: @"guid"]];
}

-(void) loadArticles{
    readArticleIds = [self loadReadArticles];
    [super loadArticles];
}

-(NSArray *) loadReadArticles{
    NSPredicate *readArticlesPredicate = [NSPredicate predicateWithFormat:@"read == 1"];
    return Underscore.array([self loadStoredFeedEntries:readArticlesPredicate])
    .map(^(id obj){
        return [obj valueForKey:@"guid"];
    }).unwrap;
}

-(NSManagedObject *) createNewFeedEntry{
    return [NSEntityDescription insertNewObjectForEntityForName:@"FeedEntry" inManagedObjectContext: self.managedObjectContext];
}

-(NSManagedObject *) fetchFeedEntry: (NSString *) guid{
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat: @"guid == %@", guid];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity: [NSEntityDescription entityForName:@"FeedEntry" inManagedObjectContext: self.managedObjectContext]];
    
    [request setPredicate: searchPredicate];
    
    NSError *error = nil;
    
    NSArray *resultset = [[self managedObjectContext] executeFetchRequest:request error:&error];
    
    if([resultset count] == 0){
        return 0;
    }
    return [resultset objectAtIndex:0];
}

- (NSManagedObject *) fetchOrCreateFeedEntry: (NSString *) guid{
    
    NSManagedObject *feedEntry = nil;
    
    feedEntry = [self fetchFeedEntry: guid];
    
    if(!feedEntry){
        feedEntry = [self createNewFeedEntry];
        [feedEntry setValue:guid forKey:@"guid"];
    }
    return feedEntry;
}

-(void) markAsRead{

    FeedItem *feedItem = [self selectedFeedItem];
    
    NSManagedObject *readEntry = nil;
    
    readEntry = [self fetchOrCreateFeedEntry:feedItem.guid];

    [readEntry setValue: [NSNumber numberWithBool:YES] forKey:@"read"];
    
    [[self managedObjectContext] save: nil];
    
    [[self feedItems] removeObjectAtIndex: [self selectedIndex]];
    [self refreshBindings];
}

-(void)fav{
    FeedItem *feedItem = [self selectedFeedItem];
    
    NSManagedObject *favEntry = [self fetchOrCreateFeedEntry:feedItem.guid];
    
    [favEntry setValue: [NSNumber numberWithBool:YES] forKey:@"fav"];
    
    [[self managedObjectContext] save: nil];
    
    [self willChangeValueForKey:@"feedItems"];
    [self didChangeValueForKey:@"feedItems"];
}

@end
