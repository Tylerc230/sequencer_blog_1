//
//  SequencerEntry.m
//  Sequencer
//
//  Created by Tyler Casselman on 6/25/11.
//  Copyright 2011 SFSoftwareist. All rights reserved.
//

#import "SequencerEntry.h"

@interface SequencerEntry ()

@end

@implementation SequencerEntry
@synthesize dependencies = dependencies_;

- (id)initWithTarget:(id)target action:(SEL)action dependencies:(NSSet*)dependencies
{
	if((self = [super init]))
	{
		target_ = [target retain];
		action_ = action;
		dependencies_ = [[NSSet alloc] initWithSet:dependencies];
	}
	return self;
}

- (void)execute
{
	[target_ performSelector:action_];
}

- (void)dealloc
{
	[target_ release], target_ = nil;
	[dependencies_ release], dependencies_ = nil;
	[super dealloc];
}

@end
