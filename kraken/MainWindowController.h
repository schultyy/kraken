//
//  MainWindowController.h
//  kraken
//
//  Created by Jan Schulte on 01/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TimelineViewController.h"
#import "FavTimelineControllerViewController.h"

@interface MainWindowController : NSWindowController

@property (retain) TimelineViewController *timelineController;

@property (retain) FavTimelineControllerViewController *favTimelineController;

@property (retain) NSNumber *canRefresh;

@property IBOutlet NSBox *currentView;

-(IBAction)reload:(id)sender;

-(IBAction)showTimeline:(id)sender;

-(IBAction)showFavs:(id)sender;

@end
