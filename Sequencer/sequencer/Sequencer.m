//
//  Sequencer.m
//  Sequencer
//
//  Created by Tyler Casselman on 6/25/11.
//  Copyright 2011 SFSoftwareist. All rights reserved.
//

#import "Sequencer.h"
#import "SequencerEntry.h"

@interface Sequencer ()
- (void)checkForResolvedEntries;
@end

@implementation Sequencer
@dynamic numUnresolvedEntries;

- (id)init
{
	if((self = [super init]))
	{
		entries_ = [[NSMutableArray alloc] init];
		resolvedDependencies_ = [[NSMutableSet alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[resolvedDependencies_ release], resolvedDependencies_ = nil;
	[entries_ release], entries_ = nil;
	[super dealloc];
}

- (void)addTarget:(id)target action:(SEL)action dependencies:(int)dependancy1,...
{
	va_list dependencies;
	va_start(dependencies, dependancy1);
	NSMutableSet * dependencySet = [NSMutableSet setWithCapacity:10];
	for (int dependency = dependancy1; dependency != 0; dependency = va_arg(dependencies, int)) {
		[dependencySet addObject:[NSNumber numberWithInt:dependency]];
	}
	va_end(dependencies);
	
	SequencerEntry * newEntry = [[SequencerEntry alloc] initWithTarget:target action:action dependencies:dependencySet];
	[entries_ addObject:newEntry];
	[newEntry release];
	[self checkForResolvedEntries];
}

- (void)resolveDependency:(int)d
{
	NSNumber * dependency = [NSNumber numberWithInt:d];
	if([resolvedDependencies_ containsObject:dependency])
		return;
	
	[resolvedDependencies_ addObject:dependency];
	[self checkForResolvedEntries];
}

- (void)checkForResolvedEntries
{
	NSMutableArray * resolvedEntries = [NSMutableArray arrayWithCapacity:entries_.count];
	//determine which entries can be executed and removed
	for (SequencerEntry * entry in entries_) {
		if([entry.dependencies isSubsetOfSet:resolvedDependencies_])
		{
			[resolvedEntries addObject:entry];
		}
	}
	//remove from the list of entries that still need resolving
	[entries_ removeObjectsInArray:resolvedEntries];
	//execute resolution (execute could potentially call checkForResolvedEntries recursively)
	for(SequencerEntry * entry in resolvedEntries)
	{
		//execute method and remove
		[entry execute];		
	}


}

- (int)numUnresolvedEntries
{
	return entries_.count;
}

@end
