//
//  Sequencer.m
//  Sequencer
//
//  Created by Tyler Casselman on 6/25/11.
//  Copyright 2011 SFSoftwareist. All rights reserved.
//

#import "Sequencer.h"


@implementation Sequencer
@dynamic numUnresolvedDependencies;
- (void)addTarget:(id)target action:(SEL)action dependencies:(int)dependancy1,...
{
	
}

- (int)numUnresolvedDependencies
{
	return 0;
}

@end
