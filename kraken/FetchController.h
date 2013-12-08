//
//  FetchController.h
//  kraken
//
//  Created by Jan Schulte on 07/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FeedItem.h"

@interface FetchController : NSViewController{
    NSSortDescriptor *dateDescriptor;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (retain) NSMutableArray *feedItems;

@property (retain) NSMutableIndexSet *selections;

@property IBOutlet NSTableView *tableView;

@property (retain) NSMenu *contextMenu;

-(void) openArticle;

-(void) buildContextMenu;

/*
 * Called everytime to determine, if a certain article can be be
 * inserted or not
 * This method is meant to be overwritten in subclasses, returns YES by default
 */
-(BOOL) canAddArticle: (FeedItem *) obj;

-(void) loadArticles;

-(void) clear;

-(void) refreshBindings;

-(FeedItem *) selectedFeedItem;

-(NSInteger) selectedIndex;

-(NSArray *) loadStoredFeedEntries:(NSPredicate *) predicate;

@end
