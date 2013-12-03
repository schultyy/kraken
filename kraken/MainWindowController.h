//
//  MainWindowController.h
//  kraken
//
//  Created by Jan Schulte on 01/12/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainWindowController : NSWindowController{
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(NSArray *) feeds;

@end
