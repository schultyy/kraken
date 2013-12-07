//
//  TimelineViewController.h
//  kraken
//
//  Created by Jan Schulte on 07/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TimelineViewController : NSViewController{
    NSSortDescriptor *dateDescriptor;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (retain) NSMutableArray *feedItems;

-(void) loadArticles;
@end
