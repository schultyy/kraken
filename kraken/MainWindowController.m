//
//  MainWindowController.m
//  kraken
//
//  Created by Jan Schulte on 01/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import "MainWindowController.h"
#import "TimelineViewController.h"
#import "FavTimelineControllerViewController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (id)init{
    self = [super initWithWindowNibName:@"MainWindow"];
    if (self) {
        [self setTimelineController:[[TimelineViewController alloc] init]];
        [self setFavTimelineController: [[FavTimelineControllerViewController alloc] init]];
        [self setCanRefresh: [NSNumber numberWithBool:YES]];
    }
    return self;
}

-(IBAction)showFavs:(id)sender{
    [[self favTimelineController] clear];
    [[self favTimelineController] loadArticles];
    id favView = [[self favTimelineController] view];
    [[self currentView] setContentView:favView];
    [self setCanRefresh: [NSNumber numberWithBool:NO]];
}

-(IBAction)showTimeline:(id)sender{
    
    id timelineView = [[self timelineController] view];
    
    [[self currentView] setContentView: timelineView];
    
    [self setCanRefresh: [NSNumber numberWithBool:YES]];
}

-(IBAction)reload:(id)sender{

    [[self timelineController] clear];
    
    [[self timelineController] loadArticles];
    
    id timelineView = [[self timelineController] view];
    
    NSProgressIndicator *indicator = [[NSProgressIndicator alloc] init];
    
    [indicator setStyle:NSProgressIndicatorSpinningStyle];
    
    [[self currentView] setContentView:indicator];
    
    [indicator startAnimation:sender];
    
    [[self currentView] setContentView: timelineView];
    
    [indicator stopAnimation:sender];
}

-(void) windowDidLoad{
    [self reload: self];
}
@end
