//
//  SubscriptionWindowController.h
//  kraken
//
//  Created by Jan Schulte on 27/11/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SubscriptionWindowController : NSWindowController<NSWindowDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
