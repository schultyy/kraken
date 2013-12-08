//
//  FetchController.m
//  kraken
//
//  Created by Jan Schulte on 07/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import "FetchController.h"
#import "FeedLoader.h"
#import "AppDelegate.h"
#import "Underscore.h"

@implementation FetchController

- (id)init{
    self = [super initWithNibName:@"TimelineView" bundle:nil];
    if (self) {
        // Initialization code here.
        [self setFeedItems: [[NSMutableArray alloc] init]];
        [self setSelections: [[NSMutableIndexSet alloc]init]];
        [self setContextMenu: [[NSMenu alloc] initWithTitle:@"Context menu"]];
        
        dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"pubDate" ascending:NO];
        AppDelegate *delegate = (AppDelegate*) [[NSApplication sharedApplication] delegate];
        self.managedObjectContext = delegate.managedObjectContext;
        
        [self buildContextMenu];
    }
    return self;
}

-(void) awakeFromNib{
    [[self tableView] setMenu: [self contextMenu]];
}

-(void) buildContextMenu{
    [[self contextMenu] insertItemWithTitle:@"open" action:@selector(open) keyEquivalent:@"" atIndex:0];
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

-(BOOL) canAddArticle:(FeedItem *)obj{
    return YES;
}

-(NSArray *) loadStoredFeedEntries:(NSPredicate *) predicate{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity: [NSEntityDescription entityForName:@"FeedEntry" inManagedObjectContext: self.managedObjectContext]];
    
    if(predicate){
        [fetchRequest setPredicate:predicate];
    }
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error: %@\n%@", [error localizedDescription], [error userInfo]);
        return nil;
    }
    return results;
}

-(NSArray *) feeds{
    id fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity: [NSEntityDescription entityForName:@"Feed"
                                         inManagedObjectContext: [self managedObjectContext]]];
    id context = [self managedObjectContext];
    NSError *error = nil;
    return [context executeFetchRequest:fetchRequest error:&error];
}

-(void) processFeed: (NSString *) url{
    FeedLoader *loader = [[FeedLoader alloc] init];
    id unfiltered = [loader loadFeeds:[NSArray arrayWithObject:url]];
    
    NSMutableArray *filtered = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < [unfiltered count]; i++) {
        FeedItem *current = [unfiltered objectAtIndex:i];
        if([self canAddArticle: current]){
          [filtered addObject:current];
        }
    }
    
    [[self feedItems] addObjectsFromArray:filtered];
    
    [[self feedItems] sortUsingDescriptors: @[dateDescriptor]];
    
    [self willChangeValueForKey:@"feedItems"];
    [self didChangeValueForKey:@"feedItems"];
}

-(void) refreshBindings{
    [self willChangeValueForKey:@"feedItems"];
    [self didChangeValueForKey:@"feedItems"];
}

-(void) openArticle{
    
    NSString *url = [[self selectedFeedItem] link];
    
    if(url == nil){
        return;
    }
    
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString: url]];
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

@end
