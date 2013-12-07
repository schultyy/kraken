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
    self = [super initWithNibName:@"TimelineView" bundle:nil];
    if (self) {
        // Initialization code here.
        [self setFeedItems: [[NSMutableArray alloc] init]];
        [self setSelections: [[NSMutableIndexSet alloc]init]];
        dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"pubDate" ascending:NO];
        AppDelegate *delegate = (AppDelegate*) [[NSApplication sharedApplication] delegate];
        self.managedObjectContext = delegate.managedObjectContext;
    }
    return self;
}

-(void) clear{
    [[self feedItems] removeAllObjects];
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
    
    NSArray *readArticleIds = [self loadReadArticles];
    
    //Check which elements has already been read
    feedItems = Underscore.array(feedItems).reject(^(id obj){
        return [readArticleIds containsObject:[obj valueForKey: @"guid"]];
    }).unwrap;
    
    [[self feedItems] addObjectsFromArray:feedItems];
    
    [[self feedItems] sortUsingDescriptors: @[dateDescriptor]];
    
    [self willChangeValueForKey:@"feedItems"];
    [self didChangeValueForKey:@"feedItems"];
}

-(NSArray *) loadReadArticles{
    NSFetchRequest *fetchReadArticles = [[NSFetchRequest alloc] init];
    [fetchReadArticles setEntity: [NSEntityDescription entityForName:@"FeedEntry" inManagedObjectContext: self.managedObjectContext]];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchReadArticles error:&error];
    if (error) {
        NSLog(@"Error: %@\n%@", [error localizedDescription], [error userInfo]);
        return nil;
    }
    return Underscore.array(results)
                .reject(^(id obj){
                    return (BOOL)([obj valueForKey:@"read"] && 0);
                })
              .map(^(id obj) {
                        return [obj valueForKey:@"guid"];
                    })
              .unwrap;
}

-(NSArray *) feeds{
    id fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity: [NSEntityDescription entityForName:@"Feed"
                                         inManagedObjectContext: [self managedObjectContext]]];
    id context = [self managedObjectContext];
    NSError *error = nil;
    return [context executeFetchRequest:fetchRequest error:&error];
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

-(void) refreshBindings{
    [self willChangeValueForKey:@"feedItems"];
    [self didChangeValueForKey:@"feedItems"];
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

-(IBAction) markAsRead:(id) sender{

    FeedItem *feedItem = [self selectedFeedItem];
    
    NSManagedObject *readEntry = nil;
    
    readEntry = [self fetchOrCreateFeedEntry:feedItem.guid];

    [readEntry setValue: [NSNumber numberWithBool:YES] forKey:@"read"];
    
    [[self managedObjectContext] save: nil];
    
    [[self feedItems] removeObjectAtIndex: [self selectedIndex]];
    [self refreshBindings];
}

-(IBAction)fav:(id)sender{
    FeedItem *feedItem = [self selectedFeedItem];
    
    NSManagedObject *favEntry = [self fetchOrCreateFeedEntry:feedItem.guid];
    
    [favEntry setValue: [NSNumber numberWithBool:YES] forKey:@"fav"];
    
    [[self managedObjectContext] save: nil];
    
    [self willChangeValueForKey:@"feedItems"];
    [self didChangeValueForKey:@"feedItems"];
}

-(NSInteger) selectedIndex{
    return [[self selections] firstIndex];
}

-(FeedItem *) selectedFeedItem{
    if([[self selections] count] == 0){
        return nil;
    }
    
    return [[self feedItems] objectAtIndex: [self selectedIndex]];
}

-(IBAction) openArticle: (id) sender{

    NSString *url = [[self selectedFeedItem] link];
    
    if(url == nil){
        return;
    }
    
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString: url]];
}

@end
