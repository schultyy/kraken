//
//  MainWindowController.m
//  kraken
//
//  Created by Jan Schulte on 01/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import "MainWindowController.h"
#import "TimelineViewController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (id)init{
    self = [super initWithWindowNibName:@"MainWindow"];
    if (self) {
        [self setTimelineController:[[TimelineViewController alloc] init]];
    }
    return self;
}

-(void) windowDidLoad{
    [[self timelineController] loadArticles];
    
    id timelineView = [[self timelineController] view];
    
    [[self currentView] setContentView: timelineView];
}
@end
