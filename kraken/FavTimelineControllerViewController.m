//
//  FavTimelineControllerViewController.m
//  kraken
//
//  Created by Jan Schulte on 07/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import "FavTimelineControllerViewController.h"
#import "FeedItem.h"
#import "Underscore.h"

@interface FavTimelineControllerViewController ()

@end

@implementation FavTimelineControllerViewController

-(BOOL) canAddArticle:(FeedItem *)obj{
    return [favedArticleIds containsObject: [obj valueForKey:@"guid"]];
}

-(void)loadArticles{
    favedArticleIds = [self loadFavedArticles];
    [super loadArticles];
}

-(NSArray *) loadFavedArticles{
    NSPredicate *favedArticlesPredicate = [NSPredicate predicateWithFormat:@"fav == 1"];
    return Underscore.array([self loadStoredFeedEntries:favedArticlesPredicate])
    .map(^(id obj){
        return [obj valueForKey:@"guid"];
    }).unwrap;
}

@end
