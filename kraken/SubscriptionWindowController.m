//
//  SubscriptionWindowController.m
//  kraken
//
//  Created by Jan Schulte on 27/11/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import "SubscriptionWindowController.h"
#import "AppDelegate.h"

@interface SubscriptionWindowController ()

@end

@implementation SubscriptionWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"SubscriptionWindow"];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    AppDelegate *delegate = (AppDelegate*) [[NSApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
}

-(BOOL)windowShouldClose:(id)sender{
    
    NSError *error;
    
    [[self managedObjectContext] save: &error];
    return YES;
}

@end
