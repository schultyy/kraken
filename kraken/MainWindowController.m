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
    
    NSProgressIndicator *indicator = [[NSProgressIndicator alloc] init];
    
    [indicator setStyle:NSProgressIndicatorSpinningStyle];
    
    [[self currentView] setContentView:indicator];
    
    id sender = self;
    
    [indicator startAnimation:sender];
    
    [[self currentView] setContentView: timelineView];
    
    [indicator stopAnimation:sender];
}
@end
