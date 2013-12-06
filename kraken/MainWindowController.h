//
//  MainWindowController.h
//  kraken
//
//  Created by Jan Schulte on 01/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainWindowController : NSWindowController{
    NSSortDescriptor *dateDescriptor;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (retain) NSMutableArray *feedItems;

@end
