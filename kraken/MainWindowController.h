//
//  MainWindowController.h
//  kraken
//
//  Created by Jan Schulte on 01/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TimelineViewController.h"

@interface MainWindowController : NSWindowController

@property (retain) TimelineViewController *timelineController;

@property IBOutlet NSBox *currentView;

@end
