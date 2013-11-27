//
//  AppDelegate.h
//  kraken
//
//  Created by Jan Schulte on 27/11/13.
//  Copyright (c) 2013 schultyy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SubscriptionWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain) SubscriptionWindowController *subscriptionController;

- (IBAction)saveAction:(id)sender;

-(IBAction)showSubscriptions:(id)sender;

@end
